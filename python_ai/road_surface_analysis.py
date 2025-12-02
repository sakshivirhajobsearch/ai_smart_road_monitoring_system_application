import pandas as pd
from utils.logger import get_logger

logger = get_logger(__name__)

def analyze_surface(sensor_file):
    try:
        df = pd.read_excel(sensor_file) if sensor_file.endswith("xlsx") else pd.read_csv(sensor_file)
    except Exception as e:
        raise Exception(f"Invalid sensor file: {e}")

    avg_vibration = float(df['vibration'].mean())
    avg_temp = float(df['temp'].mean())

    condition = "GOOD"
    if avg_vibration > 5 or avg_temp > 50:
        condition = "BAD"

    return {
        "sensor_file": sensor_file,
        "vibration": avg_vibration,
        "temperature": avg_temp,
        "condition": condition
    }
