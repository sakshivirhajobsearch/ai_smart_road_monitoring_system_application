from flask import Flask, request, jsonify
from pothole_detection import predict_pothole
from road_surface_analysis import analyze_surface
from utils.logger import get_logger
import os

logger = get_logger(__name__)
app = Flask(__name__)


# ============================
# Health Check
# ============================
@app.route("/")
def home():
    return jsonify({
        "status": "AI Flask Server Running",
        "version": "1.0",
        "endpoints": ["/predict", "/analyze"]
    })


# ============================
# Pothole Prediction API
# (Matches Java `flask.server.url`)
# ============================
@app.route("/predict", methods=["POST"])
def predict_api():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Missing JSON payload"}), 400

        image_path = data.get("image_path")
        if not image_path:
            return jsonify({"error": "Missing image_path"}), 400

        abs_path = os.path.abspath(image_path)
        if not os.path.exists(abs_path):
            return jsonify({"error": f"Image file not found: {abs_path}"}), 400

        logger.info(f"Running pothole prediction on: {abs_path}")
        result = predict_pothole(abs_path)
        return jsonify(result)

    except Exception as e:
        logger.error(f"Prediction failed: {e}")
        return jsonify({"error": str(e)}), 500


# ============================
# Road Surface Analysis API
# ============================
@app.route("/analyze", methods=["POST"])
def analyze_api():
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Missing JSON payload"}), 400

        sensor_file = data.get("sensor_file")
        if not sensor_file:
            return jsonify({"error": "Missing sensor_file"}), 400

        abs_path = os.path.abspath(sensor_file)
        if not os.path.exists(abs_path):
            return jsonify({"error": f"Sensor data file not found: {abs_path}"}), 400

        logger.info(f"Running surface analysis on: {abs_path}")
        result = analyze_surface(abs_path)
        return jsonify(result)

    except Exception as e:
        logger.error(f"Surface analysis failed: {e}")
        return jsonify({"error": str(e)}), 500


# ============================
# Server Start
# ============================
if __name__ == "__main__":
    # MUST match application.properties
    app.run(host="0.0.0.0", port=5000, debug=True)
