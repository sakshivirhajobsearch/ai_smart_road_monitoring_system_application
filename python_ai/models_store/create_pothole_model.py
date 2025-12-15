import numpy as np
import joblib
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression

# -----------------------------
# Generate dummy sensor data
# -----------------------------
np.random.seed(42)

samples = 1000

vibration = np.random.uniform(0, 10, samples)
speed = np.random.uniform(20, 80, samples)
temperature = np.random.uniform(15, 45, samples)
depth = np.random.uniform(0, 1.5, samples)

X = np.column_stack((vibration, speed, temperature, depth))

# Severity labels
y = []
for v, d in zip(vibration, depth):
    if v < 3 and d < 0.3:
        y.append(0)   # LOW
    elif v < 6 and d < 0.8:
        y.append(1)   # MEDIUM
    else:
        y.append(2)   # HIGH

y = np.array(y)

# -----------------------------
# Scale data
# -----------------------------
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# -----------------------------
# Train model
# -----------------------------
model = LogisticRegression(
    multi_class="multinomial",
    solver="lbfgs",
    max_iter=1000
)
model.fit(X_scaled, y)

# -----------------------------
# Save files
# -----------------------------
joblib.dump(model, "pothole_model.pkl")
joblib.dump(scaler, "scaler.pkl")

print("✅ pothole_model.pkl created")
print("✅ scaler.pkl created")
print("🎯 Classes: LOW(0), MEDIUM(1), HIGH(2)")
