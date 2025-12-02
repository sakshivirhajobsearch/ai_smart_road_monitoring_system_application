import joblib
import os
from sklearn.ensemble import RandomForestClassifier

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_DIR = os.path.join(BASE_DIR, "models")
os.makedirs(MODEL_DIR, exist_ok=True)

model_path_pkl = os.path.join(MODEL_DIR, "pothole_model.pkl")
model_path_joblib = os.path.join(MODEL_DIR, "pothole_model.joblib")

# Dummy model
clf = RandomForestClassifier()
# Fit on dummy data
clf.fit([[0,1],[1,0],[1,1],[0,0]], [0,1,1,0])

joblib.dump(clf, model_path_pkl)
joblib.dump(clf, model_path_joblib)

print(f"Dummy models saved:\n{model_path_pkl}\n{model_path_joblib}")
