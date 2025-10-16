import requests
import os

BASE_URL = "http://127.0.0.1:5000"

# Test images
test_images = [
    r"test_image_1.jpg",
    r"test_image_2.jpg",
    r"test_image_3.jpg",
    r"test_image_4.jpg",
    r"test_image_5.jpg",
]

# Pothole prediction
for img_path in test_images:
    if not os.path.exists(img_path):
        print(f"File not found: {img_path}")
        continue
    resp = requests.post(f"{BASE_URL}/api/predict_pothole", json={"image_path": img_path})
    try:
        print(f"Pothole Prediction for {img_path}:", resp.json())
    except Exception:
        print(f"Non-JSON response for {img_path}:", resp.text)

# Surface analysis
sensor_file = r"data/sensor_log.xlsx"
if os.path.exists(sensor_file):
    resp = requests.post(f"{BASE_URL}/api/analyze_surface", json={"sensor_file": sensor_file})
    try:
        print("Surface Analysis:", resp.json())
    except Exception:
        print("Non-JSON response:", resp.text)
else:
    print(f"Sensor log file not found: {sensor_file}")
