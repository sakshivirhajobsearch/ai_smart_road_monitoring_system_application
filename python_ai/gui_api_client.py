import tkinter as tk
from tkinter import filedialog, messagebox
import requests
import json

BASE_URL = "http://127.0.0.1:5000"


def send_request(endpoint, payload=None):
    url = BASE_URL + endpoint

    try:
        response = requests.post(url, json=payload) if payload else requests.get(url)

        # Empty response check
        if not response.text.strip():
            messagebox.showerror("Error", "Server returned an empty response")
            return

        # Try JSON parse
        try:
            data = response.json()
        except Exception:
            messagebox.showerror("Error", "Invalid JSON:\n" + response.text)
            return

        # Display nicely
        output_box.delete(1.0, tk.END)
        output_box.insert(tk.END, json.dumps(data, indent=4))

    except Exception as e:
        messagebox.showerror("Error", f"Request failed:\n{str(e)}")


def check_api_status():
    send_request("/")


def predict_pothole():
    image_path = filedialog.askopenfilename(
        title="Select test image",
        filetypes=[("Images", "*.jpg *.png *.jpeg")]
    )
    if not image_path:
        return

    send_request("/api/predict_pothole", {"image_path": image_path})


def analyze_surface():
    sensor_file = filedialog.askopenfilename(
        title="Select sensor CSV file",
        filetypes=[("CSV Files", "*.csv")]
    )
    if not sensor_file:
        return

    send_request("/api/analyze_surface", {"sensor_file": sensor_file})


# ---------------- GUI ----------------

root = tk.Tk()
root.title("AI Smart Road Monitoring - API GUI")
root.geometry("900x600")

title = tk.Label(root, text="AI Smart Road Monitoring - API GUI",
                 font=("Arial", 20, "bold"), fg="#0047AB")
title.pack(pady=20)

frame = tk.Frame(root)
frame.pack()

btn_status = tk.Button(frame, text="Check API Status", width=20,
                       command=check_api_status)
btn_status.grid(row=0, column=0, padx=10)

btn_pothole = tk.Button(frame, text="Predict Pothole", width=20,
                        command=predict_pothole)
btn_pothole.grid(row=0, column=1, padx=10)

btn_surface = tk.Button(frame, text="Analyze Surface", width=20,
                        command=analyze_surface)
btn_surface.grid(row=0, column=2, padx=10)

output_box = tk.Text(root, height=22, width=110, font=("Consolas", 10))
output_box.pack(pady=20)

root.mainloop()
