import os
import joblib
from utils.image_processing import extract_pothole_features
from utils.logger import get_logger

logger = get_logger(__name__)

MODEL_PATH = "models/pothole_model.joblib"

if not os.path.exists(MODEL_PATH) or os.path.getsize(MODEL_PATH) == 0:
    logger.error(f"Model file missing or empty: {MODEL_PATH}")
    raise FileNotFoundError(f"Model file missing or empty: {MODEL_PATH}")

try:
    model = joblib.load(MODEL_PATH)
    logger.info("Model loaded successfully")
except EOFError:
    logger.error(f"Model file corrupted: {MODEL_PATH}")
    raise EOFError(f"Model file corrupted: {MODEL_PATH}")

def predict_pothole(image_path):
    features = extract_pothole_features(image_path)
    # Dummy prediction logic: replace with actual model.predict(features)
    import random
    result = random.choice([True, False])
    confidence = round(random.uniform(0.75, 0.99), 2)
    logger.info(f"Pothole prediction for {image_path}: {result}, confidence: {confidence}")
    return {"pothole_detected": result, "confidence_score": confidence, "image_path": image_path}
