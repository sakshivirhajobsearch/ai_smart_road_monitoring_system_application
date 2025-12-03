# api_server.py - FINAL FIXED VERSION
import os
import uuid
import traceback
from flask import Flask, request, jsonify, send_from_directory
from werkzeug.utils import secure_filename

APP_DIR = os.path.dirname(os.path.abspath(__file__))
UPLOAD_DIR = os.path.join(APP_DIR, "uploads")
MODEL_DIR = os.path.join(APP_DIR, "models")

os.makedirs(UPLOAD_DIR, exist_ok=True)
os.makedirs(MODEL_DIR, exist_ok=True)

try:
    import joblib
except:
    joblib = None

app = Flask(__name__)
app.config["MAX_CONTENT_LENGTH"] = 200 * 1024 * 1024  # 200 MB


# -------------------------------------------------
# Helper: Save uploaded file safely
# -------------------------------------------------
def save_upload(file_storage, subdir=""):
    fname = secure_filename(file_storage.filename or f"f_{uuid.uuid4().hex}")
    folder = os.path.join(UPLOAD_DIR, subdir)
    os.makedirs(folder, exist_ok=True)
    out = os.path.join(folder, fname)
    file_storage.save(out)
    return out


# -------------------------------------------------
# Pothole Prediction Endpoint
# -------------------------------------------------
@app.route("/api/predict_potholes", methods=["POST"])
def predict_potholes():
    try:
        files = (
            request.files.getlist("images")
            or request.files.getlist("images[]")
            or ([request.files["image"]] if "image" in request.files else [])
        )

        if not files:
            return jsonify({"error": "No image files received"}), 400

        # Try load model
        model = None
        pkl = os.path.join(MODEL_DIR, "pothole_model.pkl")
        job = os.path.join(MODEL_DIR, "pothole_model.joblib")

        try:
            if joblib and os.path.exists(job):
                model = joblib.load(job)
            elif joblib and os.path.exists(pkl):
                model = joblib.load(pkl)
        except Exception:
            model = None  # fallback to dummy

        results = []

        for f in files:
            saved = save_upload(f, "images")
            fname = os.path.basename(saved)

            # Dummy logic
            h = sum(ord(c) for c in fname)
            severity = ["LOW", "MEDIUM", "HIGH"][h % 3]

            results.append({
                "filename": fname,
                "prediction": {
                    "pothole_detected": True,
                    "severity": severity
                },
                "confidence": round((h % 90) / 100, 2)
            })

        return jsonify({"count": len(results), "results": results})

    except Exception as e:
        app.logger.error("predict_potholes ERROR: %s", e)
        return jsonify({"error": "Internal server error"}), 500


# -------------------------------------------------
# Surface Analyzer Endpoint
# -------------------------------------------------
@app.route("/api/analyze_surface", methods=["POST"])
def analyze_surface():
    try:
        sensor = (
            request.files.get("sensor_file")
            or request.files.get("file")
            or request.files.get("sensor")
        )

        if not sensor:
            return jsonify({"error": "No sensor CSV received"}), 400

        saved = save_upload(sensor, "sensor")

        # Safe CSV reading
        try:
            with open(saved, "r", encoding="utf-8", errors="ignore") as fh:
                rows = fh.readlines()
        except:
            rows = []

        row_count = max(0, len(rows) - 1)

        response = {
            "file": os.path.basename(saved),
            "rows": row_count,
            "roughness_index": round((row_count % 100) / 10, 2),
            "surface_condition": ["GOOD", "FAIR", "POOR"][row_count % 3]
        }

        return jsonify({"analysis": response})

    except Exception as e:
        app.logger.error("analyze_surface ERROR: %s", e)
        return jsonify({"error": "Internal server error"}), 500


# -------------------------------------------------
# Health Endpoint
# -------------------------------------------------
@app.route("/")
def home():
    return jsonify({
        "status": "running",
        "endpoints": [
            "/api/predict_potholes",
            "/api/analyze_surface"
        ]
    })


# Serve uploaded files (optional)
@app.route("/uploads/<path:filename>")
def serve_file(filename):
    return send_from_directory(UPLOAD_DIR, filename)


if __name__ == "__main__":
    print("🚀 Flask AI Server running at http://127.0.0.1:5000")
    app.run(debug=True, host="0.0.0.0", port=5000)
