import os, json, csv, zipfile
from PIL import Image
import numpy as np
import pandas as pd

BASE = r"E:\Project-Sakshi\ai_smart_road_monitoring_system_application"
OUT = os.path.join(BASE, "ai_dummy_dataset_large")
os.makedirs(OUT, exist_ok=True)

print("\n📁 Creating LARGE dataset:", OUT)

# =====================================================================
# 1. DIRECTORY STRUCTURE
# =====================================================================
DIR_MODELS = os.path.join(OUT, "models")
DIR_DATA = os.path.join(OUT, "data")
DIR_IMAGES = os.path.join(OUT, "images")
DIR_UPLOADS = os.path.join(OUT, "uploads")
DIR_MYSQL = os.path.join(OUT, "mysql")
DIR_REPORTS = os.path.join(OUT, "reports")

for d in [DIR_MODELS, DIR_DATA, DIR_IMAGES, DIR_UPLOADS, DIR_MYSQL, DIR_REPORTS]:
    os.makedirs(d, exist_ok=True)

# =====================================================================
# 2. MODEL FILES
# =====================================================================
open(os.path.join(DIR_MODELS, "pothole_model.pkl"), "wb").write(b"DUMMY_LARGE_PKL")
open(os.path.join(DIR_MODELS, "pothole_model.joblib"), "wb").write(b"DUMMY_LARGE_JOBLIB")
open(os.path.join(DIR_MODELS, "scaler.pkl"), "wb").write(b"DUMMY_LARGE_SCALER")

# =====================================================================
# 3. CSV BASED SENSOR / SURFACE DATA
# =====================================================================
# sample_sensor.csv
sensor_csv = os.path.join(DIR_DATA, "sample_sensor.csv")
with open(sensor_csv, "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["timestamp", "vibration", "pressure"])
    for i in range(500):
        w.writerow([
            f"2025-01-01 10:{i%60:02d}:{i%60:02d}",
            np.random.randint(1, 30),
            np.random.randint(20, 250)
        ])

# dummy_surface_data.csv
surface_csv = os.path.join(DIR_DATA, "dummy_surface_data.csv")
with open(surface_csv, "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["point", "roughness"])
    for i in range(300):
        w.writerow([i + 1, round(np.random.uniform(1.0, 9.9), 3)])

# dummy_sensor_stream.json
json.dump(
    [{"t": i, "value": float(np.random.random())} for i in range(500)],
    open(os.path.join(DIR_DATA, "dummy_sensor_stream.json"), "w"),
    indent=4
)

# =====================================================================
# 4. JSON DATASETS
# =====================================================================
# dummy_pothole_data.json
json.dump(
    {"potholes": [
        {"id": i,
         "lat": 22.00 + (i * 0.004),
         "lon": 82.00 + (i * 0.004),
         "severity": np.random.choice(["LOW", "MEDIUM", "HIGH"])}
        for i in range(200)
    ]},
    open(os.path.join(DIR_DATA, "dummy_pothole_data.json"), "w"), indent=4
)

# gps_sample_data.json
json.dump(
    {"gps": [{"lat": 22.10 + (i * 0.002), "lon": 82.10 + (i * 0.002)} for i in range(200)]},
    open(os.path.join(DIR_DATA, "gps_sample_data.json"), "w"), indent=4
)

# dummy_image_list.json
json.dump(
    {"files": [f"dummy_upload_{i}.jpg" for i in range(1, 21)]},
    open(os.path.join(DIR_DATA, "dummy_image_list.json"), "w"), indent=4
)

# potholes_data.json
json.dump(
    {"records": [{
        "id": i,
        "severity": np.random.choice(["LOW", "MEDIUM", "HIGH"])
    } for i in range(500)]},
    open(os.path.join(DIR_DATA, "potholes_data.json"), "w"),
    indent=4
)

# road_data.json
json.dump(
    {"road_segments": [
        {"id": i, "quality": np.random.randint(1, 10)}
        for i in range(100)
    ]},
    open(os.path.join(DIR_DATA, "road_data.json"), "w"),
    indent=4
)

# dashboard_data.json
json.dump(
    {
        "summary": {
            "total_potholes": 540,
            "repaired": 284,
            "pending": 256
        }
    },
    open(os.path.join(DIR_DATA, "dashboard_data.json"), "w"),
    indent=4
)

# =====================================================================
# 5. TEST IMAGES
# =====================================================================
for i in range(1, 6):
    img = Image.fromarray(np.random.randint(0,255,(300,300,3),dtype=np.uint8))
    img.save(os.path.join(DIR_IMAGES, f"test_image_{i}.jpg"))

# =====================================================================
# 6. 100 UPLOAD IMAGES
# =====================================================================
for i in range(1, 101):
    img = Image.fromarray(np.random.randint(0,255,(300,300,3),dtype=np.uint8))
    img.save(os.path.join(DIR_UPLOADS, f"dummy_upload_{i}.jpg"))

# batch zip
zip_path = os.path.join(DIR_UPLOADS, "dummy_batch_upload.zip")
with zipfile.ZipFile(zip_path, "w") as z:
    for i in range(1, 6):
        f = os.path.join(DIR_UPLOADS, f"dummy_upload_{i}.jpg")
        z.write(f, f"dummy_upload_{i}.jpg")

# =====================================================================
# 7. MYSQL SQL FILES
# =====================================================================
# create.sql
open(os.path.join(DIR_MYSQL, "create.sql"), "w").write("-- CREATE TABLE schema definitions here")

# drop.sql
open(os.path.join(DIR_MYSQL, "drop.sql"), "w").write("-- DROP TABLE statements here")

# reset.sql
open(os.path.join(DIR_MYSQL, "reset.sql"), "w").write("-- TRUNCATE TABLE statements here")

# insert.sql
open(os.path.join(DIR_MYSQL, "insert.sql"), "w").write("-- INSERT statements here")

# delete.sql
open(os.path.join(DIR_MYSQL, "delete.sql"), "w").write("-- DELETE statements here")

# select.sql
open(os.path.join(DIR_MYSQL, "select.sql"), "w").write("-- SELECT queries here")

# update.sql
open(os.path.join(DIR_MYSQL, "update.sql"), "w").write("-- UPDATE queries here")

# activity_log_large.sql (1000 rows)
open(os.path.join(DIR_MYSQL, "activity_log_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO activity_log (action_type, description) "
        f"VALUES ('INFO', 'Log entry {i}');"
        for i in range(1000)
    ])
)

# pothole_large.sql (500 rows)
open(os.path.join(DIR_MYSQL, "pothole_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO pothole (latitude, longitude, severity) VALUES "
        f"(22.{i%99}, 82.{i%99}, '{np.random.choice(['LOW','MEDIUM','HIGH'])}');"
        for i in range(500)
    ])
)

# repair_activity_large.sql
open(os.path.join(DIR_MYSQL, "repair_activity_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO repair_activity (pothole_id, repair_status) VALUES "
        f"({i}, '{np.random.choice(['PENDING','IN_PROGRESS','COMPLETED'])}');"
        for i in range(500)
    ])
)

# roles.sql
open(os.path.join(DIR_MYSQL, "roles.sql"), "w").write(
    "INSERT INTO role (name) VALUES "
    "('ADMIN'),('USER'),('PWD'),('COLLECTOR'),('MUNICIPAL');"
)

# users_large.sql
open(os.path.join(DIR_MYSQL, "users_large.sql"), "w").write(
    "\n".join([
        f"INSERT INTO user (username,password,enabled,role_id) "
        f"VALUES ('user{i}', '{{noop}}pass{i}', 1, {np.random.randint(1,6)});"
        for i in range(1, 201)
    ])
)

# =====================================================================
# 8. REPORT FILES
# =====================================================================
pd.DataFrame({
    "date": [f"2025-01-{i:02d}" for i in range(1, 31)],
    "detected": np.random.randint(5, 30, 30)
}).to_csv(os.path.join(DIR_REPORTS, "daily_report.csv"), index=False)

pd.DataFrame({
    "month": ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
    "repairs_completed": np.random.randint(20, 100, 6)
}).to_excel(os.path.join(DIR_REPORTS, "monthly_summary.xlsx"), index=False)

pd.DataFrame({
    "timestamp": [f"2025-01-01 10:{i:02d}:00" for i in range(60)],
    "value": np.random.random(60)
}).to_csv(os.path.join(DIR_REPORTS, "sensor_log.csv"), index=False)

pd.DataFrame({
    "timestamp": [f"2025-01-02 11:{i:02d}:00" for i in range(60)],
    "value": np.random.random(60)
}).to_excel(os.path.join(DIR_REPORTS, "sensor_log.xlsx"), index=False)

# =====================================================================
# 9. ZIP FINAL OUTPUT
# =====================================================================
ZIP_OUT = os.path.join(BASE, "ai_dummy_dataset_large.zip")

with zipfile.ZipFile(ZIP_OUT, "w", zipfile.ZIP_DEFLATED) as z:
    for root, _, files in os.walk(OUT):
        for f in files:
            full = os.path.join(root, f)
            rel = os.path.relpath(full, OUT)
            z.write(full, rel)

print("\n✅ LARGE DUMMY DATASET CREATED SUCCESSFULLY!")
print("📦 ZIP:", ZIP_OUT)
print("📁 Folder:", OUT)
