# pothole_detection.py
import joblib
import numpy as np
import cv2
import os
from datetime import datetime

MODEL_PATH = os.path.join(os.path.dirname(__file__), "pothole_model.pkl")
SCALER_PATH = os.path.join(os.path.dirname(__file__), "scaler.pkl")

# Load model and scaler
model = joblib.load(MODEL_PATH)
scaler = joblib.load(SCALER_PATH)

def extract_features(image_path):
    """Extract simple image features for the model."""
    img = cv2.imread(image_path, cv2.IMREAD_GRAYSCALE)
    if img is None:
        raise ValueError(f"Image not found: {image_path}")

    img = cv2.resize(img, (64, 64))
    mean = np.mean(img)
    std = np.std(img)
    edge = cv2.Canny(img, 50, 150)
    edge_density = np.sum(edge > 0) / (64 * 64)
    return np.array([[mean, std, edge_density, mean * 0.1, std * 0.1]])

def predict_pothole(image_path):
    """Predict pothole presence and estimate its dimensions."""
    features = extract_features(image_path)
    scaled_features = scaler.transform(features)
    prediction = model.predict(scaled_features)[0]
    confidence = model.predict_proba(scaled_features)[0][prediction] if hasattr(model, 'predict_proba') else 0.85

    # Simulated measurements (could come from sensors)
    length = round(np.random.uniform(0.3, 1.5), 2)
    width = round(np.random.uniform(0.2, 1.0), 2)
    depth = round(np.random.uniform(0.05, 0.3), 2)

    result = {
        "status": "pothole_detected" if prediction == 1 else "no_pothole",
        "confidence": round(float(confidence), 2),
        "length": length,
        "width": width,
        "depth": depth,
        "gps": {"lat": 23.1737, "lon": 79.9478},
        "image": os.path.basename(image_path),
        "timestamp": datetime.now().isoformat()
    }
    return result

if __name__ == "__main__":
    test_img = "test_image_1.jpg"
    print(predict_pothole(test_img))
