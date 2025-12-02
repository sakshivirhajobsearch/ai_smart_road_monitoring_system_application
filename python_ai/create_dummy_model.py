import joblib
import numpy as np
from sklearn.ensemble import RandomForestClassifier
import os

os.makedirs("models", exist_ok=True)

# Dummy training data: [avg_area, max_area, depth_estimate]
X = np.random.rand(100, 3) * [5000, 10000, 5]
y = np.random.randint(0, 2, 100)

model = RandomForestClassifier(n_estimators=10, random_state=42)
model.fit(X, y)

joblib.dump(model, "models/pothole_model.joblib")
print("Dummy pothole model saved at models/pothole_model.joblib")
