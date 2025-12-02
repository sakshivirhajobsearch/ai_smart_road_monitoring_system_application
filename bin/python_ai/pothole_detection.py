import joblib
import numpy as np
import cv2
from utils.logger import get_logger

logger = get_logger(__name__)

MODEL_PATH = "python_ai/models/pothole_model.joblib"

try:
    model = joblib.load(MODEL_PATH)
    logger.info("Pothole model loaded successfully")
except Exception as e:
    logger.error(f"Error loading model: {e}")
    model = None


def predict_pothole(image_path):
    if model is None:
        raise Exception("Pothole model not loaded")

    img = cv2.imread(image_path)

    if img is None:
        raise Exception(f"Unable to read image: {image_path}")

    img = cv2.resize(img, (64, 64))
    flat = img.reshape(1, -1)

    prediction = model.predict(flat)[0]

    severity = "HIGH" if prediction == 1 else "LOW"

    return {
        "image_path": image_path,
        "pothole_detected": bool(prediction),
        "severity": severity
    }
