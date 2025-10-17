# road_surface_analysis.py
import pandas as pd
import numpy as np
import os
from datetime import datetime

def analyze_surface(sensor_file):
    """
    Analyze road surface level and smoothness from sensor data.
    """
    if not os.path.exists(sensor_file):
        raise FileNotFoundError(f"Sensor file not found: {sensor_file}")

    df = pd.read_csv(sensor_file)
    if "height" not in df.columns:
        raise ValueError("Sensor file must contain a 'height' column")

    std_dev = df["height"].std()
    mean_height = df["height"].mean()
    slope = (df["height"].iloc[-1] - df["height"].iloc[0]) / len(df)
    surface_type = "uneven" if std_dev > 1.0 else "smooth"

    result = {
        "surface_status": surface_type,
        "mean_height": round(float(mean_height), 2),
        "std_dev": round(float(std_dev), 2),
        "slope_level": round(float(slope), 3),
        "timestamp": datetime.now().isoformat()
    }

    return result

if __name__ == "__main__":
    # Example sensor data file: height, width, distance columns
    print(analyze_surface("data/sensor_data.csv"))
