@echo off
cd /d %~dp0

echo ============================================
echo   REBUILDING AI MODELS (Dummy ML Model)
echo ============================================
echo.

del models\pothole_model.joblib 2>nul
del models\pothole_model.pkl 2>nul
del models\scaler.pkl 2>nul

python create_dummy_model.py

echo.
echo ✅ Model build completed.
pause
