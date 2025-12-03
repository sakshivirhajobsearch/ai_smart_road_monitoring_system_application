import joblib
import numpy as np
from PIL import Image
import cv2
import os

MODEL_PATH = os.path.join(os.path.dirname(__file__), "pothole_model.joblib")

# Load model
try:
    model = joblib.load(MODEL_PATH)
    print(f"[INFO] Loaded model from {MODEL_PATH}")
except Exception as e:
    print(f"[ERROR] Could not load model: {e}")
    model = None


def preprocess_image(image_path):
    """Convert image to 64x64 grayscale array."""
    try:
        img = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)

        if img is None:
            raise ValueError(f"OpenCV could not read: {image_path}")

        img = cv2.resize(img, (64, 64))
        img = img.flatten() / 255.0
        return img
    except Exception as e:
        print(f"[ERROR] Preprocess failed: {e}")
        raise


def predict_pothole(image_path):
    """Return prediction result."""
    if model is None:
        return {"error": "Model not loaded"}

    try:
        features = preprocess_image(image_path)
        features = np.array(features).reshape(1, -1)

        pred = model.predict(features)[0]
        prob = getattr(model, "predict_proba", lambda x: [[0.0]])(features)[0]

        return {
            "file": os.path.basename(image_path),
            "prediction": int(pred),
            "probability": float(max(prob)),
        }

    except Exception as e:
        print(f"[ERROR] Prediction failed: {e}")
        return {"error": str(e)}
