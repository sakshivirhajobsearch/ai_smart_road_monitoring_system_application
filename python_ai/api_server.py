from flask import Flask, request, jsonify
from pothole_detection import predict_pothole
from road_surface_analysis import analyze_surface
from utils.logger import get_logger
import os

logger = get_logger(__name__)
app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "Flask AI service running",
        "endpoints": ["/api/predict_pothole", "/api/analyze_surface"]
    })

@app.route("/api/predict_pothole", methods=["POST"])
def pothole_api():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON payload"}), 400

    image_path = data.get("image_path")
    if not image_path or not os.path.exists(image_path):
        return jsonify({"error": f"Missing or invalid image_path: {image_path}"}), 400

    try:
        result = predict_pothole(image_path)
        return jsonify(result)
    except Exception as e:
        logger.error(f"Pothole prediction failed: {e}")
        return jsonify({"error": str(e)}), 500

@app.route("/api/analyze_surface", methods=["POST"])
def surface_api():
    data = request.get_json()
    if not data:
        return jsonify({"error": "Missing JSON payload"}), 400

    sensor_file = data.get("sensor_file")
    if not sensor_file or not os.path.exists(sensor_file):
        return jsonify({"error": f"Missing or invalid sensor_file: {sensor_file}"}), 400

    try:
        result = analyze_surface(sensor_file)
        return jsonify(result)
    except Exception as e:
        logger.error(f"Surface analysis failed: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
