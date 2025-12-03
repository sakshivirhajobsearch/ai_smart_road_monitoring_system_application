# python_ai/create_dummy_model.py
import os
from sklearn.dummy import DummyClassifier
import joblib

BASE_DIR = os.path.dirname(__file__)  # python_ai/
MODELS_DIR = os.path.join(BASE_DIR, "models")
os.makedirs(MODELS_DIR, exist_ok=True)

clf = DummyClassifier(strategy="most_frequent")
# train a dummy on trivial features:
X = [[0],[1],[0],[1]]
y = [0,1,0,1]
clf.fit(X,y)

joblib.dump(clf, os.path.join(MODELS_DIR, "pothole_model.joblib"))
joblib.dump(clf, os.path.join(MODELS_DIR, "pothole_model.pkl"))

print("Dummy pothole model saved at", MODELS_DIR)
