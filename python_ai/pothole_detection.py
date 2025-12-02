import os
import joblib
import numpy as np
from utils.logger import get_logger

logger = get_logger(__name__)

BASE_DIR = os.path.dirname(__file__)
MODEL_PATH = os.path.join(BASE_DIR, "pothole_model.joblib")

# Load model safely
model = None
try:
    if os.path.exists(MODEL_PATH):
        model = joblib.load(MODEL_PATH)
        logger.info(f"Model loaded: {MODEL_PATH}")
    else:
        logger.error(f"Model not found at: {MODEL_PATH}")
except Exception as e:
    logger.error(f"Error loading model: {e}")

def predict_pothole(image_path):
    if model is None:
        return {"error": "AI model not loaded"}

    arr = np.random.rand(1, 5)
    pred = model.predict(arr)

    return {
        "image_path": image_path,
        "severity": str(pred[0]),
        "status": "OK"
    }
