from utils.sensor_data_parser import parse_sensor_data
from utils.gps_module import get_gps_location
from utils.logger import get_logger

logger = get_logger(__name__)

def analyze_surface(sensor_file):
    data = parse_sensor_data(sensor_file)
    if not data:
        logger.error("No sensor data found")
        return {"error": "No sensor data found"}

    avg_slope = sum([d['slope'] for d in data]) / len(data)
    uneven_sections = [d for d in data if abs(d['slope']) > 5]
    gps_coords = get_gps_location()

    logger.info(f"Surface slope avg: {avg_slope:.2f}, uneven sections: {len(uneven_sections)}")
    return {
        "average_slope": avg_slope,
        "uneven_sections": len(uneven_sections),
        "gps": gps_coords
    }
