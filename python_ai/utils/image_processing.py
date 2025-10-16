import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import cv2
import numpy as np
from utils.logger import get_logger

logger = get_logger(__name__)

def extract_pothole_features(image_path):
    image = cv2.imread(image_path, cv2.IMREAD_COLOR)
    if image is None:
        raise ValueError(f"Could not read image: {image_path}")

    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blur = cv2.GaussianBlur(gray, (5, 5), 0)
    edges = cv2.Canny(blur, 50, 150)

    contours, _ = cv2.findContours(edges, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contour_areas = [cv2.contourArea(c) for c in contours]

    avg_area = np.mean(contour_areas) if contour_areas else 0
    max_area = np.max(contour_areas) if contour_areas else 0
    depth_estimate = np.std(gray) / 10

    logger.info(f"Image {image_path}: avg_area={avg_area}, max_area={max_area}, depth={depth_estimate}")
    return [avg_area, max_area, depth_estimate]
