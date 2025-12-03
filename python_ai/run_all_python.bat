@echo off
cd /d %~dp0

title FULL PYTHON PIPELINE
echo ============================================
echo   PYTHON AI FULL EXECUTION PIPELINE
echo ============================================
echo.

echo 🔹 Step 1: Installing requirements
pip install -r requirements.txt

echo 🔹 Step 2: Building AI models
python create_dummy_model.py

echo 🔹 Step 3: Starting Flask server...
start cmd /k "cd /d %~dp0 && python api_server.py"

echo 🔹 Step 4: Waiting 5 seconds before API test...
timeout /t 5 >nul

echo 🔹 Step 5: Running API tests
python test_api.py

echo.
echo ============================================
echo   ALL PYTHON TASKS COMPLETED SUCCESSFULLY
echo ============================================
pause
