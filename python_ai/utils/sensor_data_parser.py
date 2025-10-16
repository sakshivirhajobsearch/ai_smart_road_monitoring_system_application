import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import pandas as pd
from utils.logger import get_logger

logger = get_logger(__name__)

def parse_sensor_data(file_path):
    data = []
    try:
        df = pd.read_excel(file_path)
        for _, row in df.iterrows():
            data.append({
                "timestamp": str(row["timestamp"]),
                "acceleration": float(row["acceleration"]),
                "slope": float(row["slope"])
            })
    except Exception as e:
        logger.error(f"Error reading sensor data: {e}")
    return data
