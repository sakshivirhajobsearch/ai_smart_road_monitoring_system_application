from flask import Flask, request, jsonify
from models.pothole_detection import predict_pothole
from models.road_surface_analysis import analyze_surface

app = Flask(__name__)

@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "status": "Flask AI service running",
        "endpoints": [
            "/api/predict_pothole",
            "/api/analyze_surface"
        ]
    })


@app.route("/api/predict_pothole", methods=["POST"])
def api_predict_pothole():
    data = request.get_json(silent=True)

    if not data or "image_path" not in data:
        return jsonify({"error": "image_path is required"}), 400

    try:
        result = predict_pothole(data["image_path"])
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/api/analyze_surface", methods=["POST"])
def api_analyze_surface():
    data = request.get_json(silent=True)

    if not data or "sensor_file" not in data:
        return jsonify({"error": "sensor_file is required"}), 400

    try:
        result = analyze_surface(data["sensor_file"])
        return jsonify(result)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    print("========================================")
    print("  STARTING FLASK AI SERVER...")
    print("  URL: http://127.0.0.1:5000")
    print("========================================")
    app.run(host="127.0.0.1", port=5000, debug=True)
