from flask import Flask, request, jsonify
from models.pothole_detection import predict_pothole
from models.road_surface_analysis import analyze_surface
from utils.logger import get_logger
import os

app = Flask(__name__)
logger = get_logger(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "Flask AI server running",
        "version": "1.0",
        "endpoints": [
            "/api/predict_pothole",
            "/api/analyze_surface"
        ]
    })

# -------------------------------
# Pothole Prediction Endpoint
# -------------------------------
@app.route("/api/predict_pothole", methods=["POST"])
def api_predict_pothole():
    try:
        data = request.get_json()

        if not data or "image_path" not in data:
            return jsonify({"error": "Missing image_path"}), 400

        image_path = data["image_path"]

        # Convert relative path to absolute path
        if not os.path.isabs(image_path):
            image_path = os.path.join(os.getcwd(), image_path)

        if not os.path.exists(image_path):
            return jsonify({"error": f"Image not found: {image_path}"}), 404

        result = predict_pothole(image_path)
        return jsonify(result), 200

    except Exception as e:
        logger.error(f"Error in /api/predict_pothole: {e}")
        return jsonify({"error": str(e)}), 500


# -------------------------------
# Road Surface Analysis Endpoint
# -------------------------------
@app.route("/api/analyze_surface", methods=["POST"])
def api_analyze_surface():
    try:
        data = request.get_json()

        if not data or "sensor_file" not in data:
            return jsonify({"error": "Missing sensor_file"}), 400

        sensor_path = data["sensor_file"]

        if not os.path.isabs(sensor_path):
            sensor_path = os.path.join(os.getcwd(), sensor_path)

        if not os.path.exists(sensor_path):
            return jsonify({"error": f"Sensor file not found: {sensor_path}"}), 404

        result = analyze_surface(sensor_path)
        return jsonify(result), 200

    except Exception as e:
        logger.error(f"Error in /api/analyze_surface: {e}")
        return jsonify({"error": str(e)}), 500


# -------------------------------
# Server Start
# -------------------------------
if __name__ == "__main__":
    print("=" * 40)
    print("  STARTING FLASK AI SERVER...")
    print("  URL: http://127.0.0.1:5000")
    print("=" * 40)

    app.run(host="0.0.0.0", port=5000, debug=True)
