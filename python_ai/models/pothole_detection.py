import os
import joblib

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "pothole_model.pkl")

def load_model():
    if not os.path.exists(MODEL_PATH):
        raise FileNotFoundError(f"Model file missing: {MODEL_PATH}")
    return joblib.load(MODEL_PATH)

model = load_model()

def predict_pothole(image_path):
    # Dummy prediction logic
    return {
        "severity": "HIGH",
        "confidence": 0.87,
        "image_used": image_path
    }
