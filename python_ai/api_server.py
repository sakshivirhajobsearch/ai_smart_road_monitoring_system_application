# api_server.py
# Flask API for Smart Road Monitoring - accepts multipart uploads
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

# try to import joblib but degrade gracefully
try:
    import joblib
except Exception:
    joblib = None

app = Flask(__name__)
app.config["MAX_CONTENT_LENGTH"] = 200 * 1024 * 1024  # 200MB limit

# Helper: safe save uploaded file, returns saved path
def save_upload(file_storage, subdir=""):
    fname = secure_filename(file_storage.filename)
    if not fname:
        fname = f"file_{uuid.uuid4().hex}"
    target_dir = os.path.join(UPLOAD_DIR, subdir) if subdir else UPLOAD_DIR
    os.makedirs(target_dir, exist_ok=True)
    out_path = os.path.join(target_dir, fname)
    file_storage.save(out_path)
    return out_path

# Pothole prediction: accept "images" (list) or "images[]" (list)
@app.route("/api/predict_potholes", methods=["POST"])
def predict_potholes():
    try:
        files = request.files.getlist("images")
        if not files:
            files = request.files.getlist("images[]")

        # also accept a single file named "image"
        if not files:
            single = request.files.get("image")
            if single:
                files = [single]

        if not files:
            return jsonify({"error": "No files found in field 'images[]' or 'images' or 'image'"}), 400

        results = []
        # attempt to load model (if available)
        model = None
        model_path_pkl = os.path.join(MODEL_DIR, "pothole_model.pkl")
        model_path_joblib = os.path.join(MODEL_DIR, "pothole_model.joblib")
        try:
            if joblib and os.path.exists(model_path_joblib):
                model = joblib.load(model_path_joblib)
            elif joblib and os.path.exists(model_path_pkl):
                model = joblib.load(model_path_pkl)
        except Exception:
            # model load failed — will use dummy prediction
            app.logger.warning("Model load failed: using dummy predictor")
            app.logger.debug(traceback.format_exc())
            model = None

        for f in files:
            saved = save_upload(f, subdir="images")
            # If we had a model we'd preprocess and predict; otherwise return dummy
            if model:
                try:
                    # The real project should replace this with actual preprocessing
                    pred = model.predict([0])[0] if hasattr(model, "predict") else "UNKNOWN"
                    probability = None
                except Exception:
                    pred = "UNKNOWN"
                    probability = None
            else:
                # Dummy logic: choose severity by filename hash for deterministic but varied output
                h = sum(ord(ch) for ch in os.path.basename(saved))
                severity = ["LOW", "MEDIUM", "HIGH"][h % 3]
                pred = {"pothole_detected": True, "severity": severity}
                probability = round((h % 100) / 100, 2)

            results.append({
                "filename": os.path.relpath(saved, APP_DIR),
                "prediction": pred,
                "confidence": probability
            })

        return jsonify({"results": results, "count": len(results)})
    except Exception as e:
        app.logger.error("predict_potholes failed: %s", e)
        app.logger.debug(traceback.format_exc())
        return jsonify({"error": "Internal server error"}), 500

# Surface analysis: expects single file field "sensor_file"
@app.route("/api/analyze_surface", methods=["POST"])
def analyze_surface():
    try:
        sensor = request.files.get("sensor_file")
        if not sensor:
            # also accept "file" or "sensor"
            sensor = request.files.get("file") or request.files.get("sensor")
        if not sensor:
            return jsonify({"error": "No file found in field 'sensor_file'"}), 400

        saved = save_upload(sensor, subdir="sensor")
        # Dummy analysis: read first lines (if text/csv) and return counts & fake metrics
        summary = {"file": os.path.relpath(saved, APP_DIR)}
        try:
            with open(saved, "r", encoding="utf-8", errors="ignore") as fh:
                lines = fh.readlines()
            summary["rows"] = len(lines) - 1 if len(lines) > 1 else len(lines)
            # produce fake metrics
            summary["roughness_index"] = round((len(lines) % 100) / 10, 2)
            summary["surface_condition"] = ["GOOD", "FAIR", "POOR"][len(lines) % 3]
        except Exception:
            # if binary or not readable, still return file saved
            summary["rows"] = None
            summary["roughness_index"] = None
            summary["surface_condition"] = "UNKNOWN"

        return jsonify({"analysis": summary})
    except Exception as e:
        app.logger.error("analyze_surface failed: %s", e)
        app.logger.debug(traceback.format_exc())
        return jsonify({"error": "Internal server error"}), 500

# Basic health endpoint and endpoints list
@app.route("/api/info", methods=["GET"])
def info():
    return jsonify({
        "endpoints": ["/api/predict_potholes", "/api/analyze_surface"],
        "status": "Flask AI service running"
    })

# Serve uploaded files (for GUI to show thumbnails / filenames)
@app.route("/uploads/<path:filename>", methods=["GET"])
def serve_upload(filename):
    return send_from_directory(UPLOAD_DIR, filename, as_attachment=False)

if __name__ == "__main__":
    # app.run(debug=True, host="127.0.0.1", port=5000)
    # Use 0.0.0.0 with reloader safe for dev
    app.run(debug=True, host="0.0.0.0", port=5000)
