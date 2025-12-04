import os, json, csv, zipfile
from PIL import Image
import numpy as np
import pandas as pd

BASE = r"E:\Project-Sakshi\ai_smart_road_monitoring_system_application"
OUT = os.path.join(BASE, "ai_dummy_dataset")
os.makedirs(OUT, exist_ok=True)

print("\n📁 Creating complete AI dummy dataset at:", OUT)

# ----------------------------------------------------------
# Directory structure
# ----------------------------------------------------------
DIR_DATA = os.path.join(OUT, "data")
DIR_MODELS = os.path.join(OUT, "models")
DIR_IMAGES = os.path.join(OUT, "images")
DIR_UPLOADS = os.path.join(OUT, "uploads")
DIR_MYSQL = os.path.join(OUT, "mysql")
DIR_REPORTS = os.path.join(OUT, "reports")

for d in [DIR_DATA, DIR_MODELS, DIR_IMAGES, DIR_UPLOADS, DIR_MYSQL, DIR_REPORTS]:
    os.makedirs(d, exist_ok=True)

# ----------------------------------------------------------
# 1. AI MODEL FILES
# ----------------------------------------------------------
open(os.path.join(DIR_MODELS, "pothole_model.pkl"), "wb").write(b"DUMMY_MODEL_PKL")
open(os.path.join(DIR_MODELS, "pothole_model.joblib"), "wb").write(b"DUMMY_MODEL_JOBLIB")
open(os.path.join(DIR_MODELS, "scaler.pkl"), "wb").write(b"DUMMY_SCALER")

# ----------------------------------------------------------
# 2. SENSOR CSV & SURFACE DATA
# ----------------------------------------------------------
sensor_csv = os.path.join(DIR_DATA, "sample_sensor.csv")
with open(sensor_csv, "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["timestamp", "vibration", "pressure"])
    for i in range(50):
        w.writerow([f"2025-01-01 10:{i:02d}:00",
                    np.random.randint(1, 10),
                    np.random.randint(20, 150)])

surface_csv = os.path.join(DIR_DATA, "dummy_surface_data.csv")
with open(surface_csv, "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["point", "roughness"])
    for i in range(40):
        w.writerow([i + 1, round(np.random.random() * 10, 3)])

# dummy sensor stream
json.dump(
    [{"t": i, "val": float(np.random.random())} for i in range(80)],
    open(os.path.join(DIR_DATA, "dummy_sensor_stream.json"), "w"),
    indent=4
)

# ----------------------------------------------------------
# 3. JSON DATASETS
# ----------------------------------------------------------
json.dump(
    {
        "potholes": [{
            "id": i,
            "lat": 22.0 + i * 0.01,
            "lon": 82.0 + i * 0.01,
            "severity": np.random.choice(["LOW", "MEDIUM", "HIGH"])
        } for i in range(40)]
    },
    open(os.path.join(DIR_DATA, "dummy_pothole_data.json"), "w"),
    indent=4
)

json.dump(
    {"files": [f"dummy_image_{i}.jpg" for i in range(1, 6)]},
    open(os.path.join(DIR_DATA, "dummy_image_list.json"), "w"),
    indent=4
)

json.dump(
    {"gps": [{"lat": 22.1 + i * 0.01, "lon": 82.1 + i * 0.01} for i in range(30)]},
    open(os.path.join(DIR_DATA, "gps_sample_data.json"), "w"),
    indent=4
)

json.dump(
    {"roads": [{"id": i, "quality": np.random.randint(1, 10)} for i in range(50)]},
    open(os.path.join(DIR_DATA, "road_data.json"), "w"),
    indent=4
)

json.dump(
    {"dashboard": {"total": 200, "repaired": 62, "pending": 138}},
    open(os.path.join(DIR_DATA, "dashboard_data.json"), "w"),
    indent=4
)

json.dump(
    {"dataset": [{
        "id": i,
        "severity": np.random.choice(["LOW", "MEDIUM", "HIGH"])
    } for i in range(150)]},
    open(os.path.join(DIR_DATA, "potholes_data.json"), "w"),
    indent=4
)

# ----------------------------------------------------------
# 4. Test Images
# ----------------------------------------------------------
for i in range(1, 6):
    img = Image.fromarray(np.random.randint(0, 255, (220, 220, 3), dtype=np.uint8))
    img.save(os.path.join(DIR_IMAGES, f"test_image_{i}.jpg"))

# ----------------------------------------------------------
# 5. Upload Images & ZIP
# ----------------------------------------------------------
for i in range(1, 6):
    img = Image.fromarray(np.random.randint(0, 255, (300, 300, 3), dtype=np.uint8))
    img.save(os.path.join(DIR_UPLOADS, f"dummy_upload_{i}.jpg"))

# batch ZIP
zip_path = os.path.join(DIR_UPLOADS, "dummy_batch_upload.zip")
with zipfile.ZipFile(zip_path, "w") as z:
    for i in range(1, 6):
        z.write(os.path.join(DIR_UPLOADS, f"dummy_upload_{i}.jpg"),
                f"dummy_upload_{i}.jpg")

# ----------------------------------------------------------
# 6. SQL FILES
# ----------------------------------------------------------

# Large inserts
open(os.path.join(DIR_MYSQL, "activity_log_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO activity_log (action_type, description) "
        f"VALUES ('INFO','System log entry {i}');"
        for i in range(200)
    ])
)

open(os.path.join(DIR_MYSQL, "pothole_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO pothole (latitude, longitude, severity) "
        f"VALUES (22.{i}, 82.{i}, 'HIGH');"
        for i in range(120)
    ])
)

open(os.path.join(DIR_MYSQL, "repair_activity_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO repair_activity (pothole_id, repair_status) "
        f"VALUES ({i}, 'PENDING');"
        for i in range(120)
    ])
)

open(os.path.join(DIR_MYSQL, "roles.sql"), "w").write(
    "INSERT INTO role (name) VALUES "
    "('ADMIN'),('USER'),('PWD'),('COLLECTOR'),('MUNICIPAL');"
)

open(os.path.join(DIR_MYSQL, "users_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO user (username,password,enabled,role_id) "
        f"VALUES ('user{i}','{{noop}}pass{i}',1,2);"
        for i in range(1, 101)
    ])
)

# Basic SQL structures
open(os.path.join(DIR_MYSQL, "create.sql"), "w").write("-- CREATE TABLE statements here;")
open(os.path.join(DIR_MYSQL, "drop.sql"), "w").write("-- DROP TABLE statements here;")
open(os.path.join(DIR_MYSQL, "reset.sql"), "w").write("-- TRUNCATE TABLE statements here;")
open(os.path.join(DIR_MYSQL, "insert.sql"), "w").write("-- INSERT queries here;")
open(os.path.join(DIR_MYSQL, "delete.sql"), "w").write("-- DELETE queries here;")
open(os.path.join(DIR_MYSQL, "select.sql"), "w").write("-- SELECT queries here;")
open(os.path.join(DIR_MYSQL, "update.sql"), "w").write("-- UPDATE queries here;")

# ----------------------------------------------------------
# 7. REPORT FILES
# ----------------------------------------------------------

pd.DataFrame({
    "date": [f"2025-01-{i:02d}" for i in range(1, 31)],
    "potholes_detected": np.random.randint(1, 20, 30)
}).to_csv(os.path.join(DIR_REPORTS, "daily_report.csv"), index=False)

pd.DataFrame({
    "month": ["Jan", "Feb", "Mar", "Apr"],
    "repairs_completed": [52, 44, 68, 63]
}).to_excel(os.path.join(DIR_REPORTS, "monthly_summary.xlsx"), index=False)

pd.DataFrame({
    "timestamp": [f"2025-01-01 11:{i:02d}:00" for i in range(40)],
    "value": np.random.random(40)
}).to_csv(os.path.join(DIR_REPORTS, "sensor_log.csv"), index=False)

pd.DataFrame({
    "timestamp": [f"2025-01-02 13:{i:02d}:00" for i in range(40)],
    "value": np.random.random(40)
}).to_excel(os.path.join(DIR_REPORTS, "sensor_log.xlsx"), index=False)

# ----------------------------------------------------------
# 8. ZIP FINAL DATASET
# ----------------------------------------------------------
ZIP_PATH = os.path.join(BASE, "ai_dummy_dataset.zip")

with zipfile.ZipFile(ZIP_PATH, "w", zipfile.ZIP_DEFLATED) as zipf:
    for root, dirs, files in os.walk(OUT):
        for f in files:
            full = os.path.join(root, f)
            rel = os.path.relpath(full, OUT)
            zipf.write(full, rel)

print("\n✅ ALL FILES GENERATED SUCCESSFULLY")
print("📦 ZIP CREATED →", ZIP_PATH)
