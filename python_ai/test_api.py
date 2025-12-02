import requests
import os
import time

BASE_URL = "http://127.0.0.1:5000"

# Wait for Flask server to start
def wait_for_server():
    for i in range(10):
        try:
            r = requests.get(f"{BASE_URL}/")
            if r.status_code == 200:
                print("✅ Flask server is up!")
                return True
        except Exception:
            print("⏳ Waiting for Flask server to start...")
            time.sleep(2)
    print("❌ Flask server not reachable.")
    return False

# Test images
test_images = [
    r"test_image_1.jpg",
    r"test_image_2.jpg",
    r"test_image_3.jpg",
    r"test_image_4.jpg",
    r"test_image_5.jpg",
]

if not wait_for_server():
    exit()

# Pothole prediction
for img_path in test_images:
    if not os.path.exists(img_path):
        print(f"⚠️ File not found: {img_path}")
        continue
    resp = requests.post(f"{BASE_URL}/api/predict_pothole", json={"image_path": img_path})
    print(f"Pothole Prediction for {img_path}: {resp.text}")

# Surface analysis
sensor_file = r"data/sensor_log.xlsx"
if os.path.exists(sensor_file):
    resp = requests.post(f"{BASE_URL}/api/analyze_surface", json={"sensor_file": sensor_file})
    print("Surface Analysis:", resp.text)
else:
    print(f"⚠️ Sensor log file not found: {sensor_file}")
