import requests
import os
import time

BASE_URL = "http://127.0.0.1:5000"

def wait_for_server():
    for _ in range(10):
        try:
            r = requests.get(f"{BASE_URL}/")
            if r.status_code == 200:
                print("✅ Flask server is UP")
                return True
        except:
            print("⏳ Waiting for Flask server...")
            time.sleep(1)
    print("❌ Flask server not reachable")
    return False

if not wait_for_server():
    exit()

# Test potholes
for i in range(1, 6):
    img = f"test_image_{i}.jpg"
    if not os.path.exists(img):
        print(f"⚠ Missing: {img}")
        continue

    print(requests.post(
        f"{BASE_URL}/api/predict_pothole",
        json={"image_path": img}
    ).json())
