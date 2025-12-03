# python_ai/gui_api_client.py
import os
import requests
import json
import tkinter as tk
from tkinter import filedialog, messagebox
from PIL import Image, ImageTk

BASE_URL = "http://127.0.0.1:5000"
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
UPLOAD_PREVIEW_SIZE = (120, 80)

os.makedirs(DATA_DIR, exist_ok=True)

# --- helper: generate dummy data files if not present ---
def generate_dummy_data():
    pothole_json = os.path.join(DATA_DIR, "dummy_pothole_data.json")
    road_json = os.path.join(DATA_DIR, "dummy_road_data.json")
    sensor_csv = os.path.join(DATA_DIR, "dummy_surface_data.csv")

    if not os.path.exists(pothole_json):
        import random, datetime
        p = []
        for i in range(120):
            p.append({
                "id": i+1,
                "latitude": round(22.0 + random.random(), 6),
                "longitude": round(82.0 + random.random(), 6),
                "severity": random.choice(["HIGH","MEDIUM","LOW"]),
                "image_path": f"images/p{i+1}.jpg",
                "detected_at": (datetime.datetime.utcnow() - datetime.timedelta(hours=i)).isoformat() + "Z",
                "status": random.choice(["DETECTED","REPORTED","REPAIRED"])
            })
        with open(pothole_json,"w",encoding="utf-8") as fh:
            json.dump(p, fh, indent=2)

    if not os.path.exists(road_json):
        import random
        r = []
        for i in range(50):
            r.append({
                "id": i+1,
                "location": f"Road-{i+1}",
                "condition": random.choice(["GOOD","MODERATE","BAD"]),
                "sensor_file": f"sensor/s{i+1}.csv",
                "analyzed_at": None
            })
        with open(road_json,"w",encoding="utf-8") as fh:
            json.dump(r, fh, indent=2)

    if not os.path.exists(sensor_csv):
        import random
        headers = ["timestamp","acc_x","acc_y","acc_z","temperature"]
        with open(sensor_csv,"w",encoding='utf-8') as fh:
            fh.write(",".join(headers) + "\n")
            for i in range(200):
                fh.write(f"2025-12-03T00:{i%60:02d}:00Z,{random.uniform(-5,5):.3f},{random.uniform(-5,5):.3f},{random.uniform(-10,10):.3f},{random.uniform(20,45):.2f}\n")

generate_dummy_data()

# --- GUI ---
root = tk.Tk()
root.title("AI Smart Road Monitoring - API GUI")
root.geometry("1000x700")

title = tk.Label(root, text="AI Smart Road Monitoring - API GUI", font=("Segoe UI", 20, "bold"), fg="#003f8a")
title.pack(pady=12)

btn_frame = tk.Frame(root)
btn_frame.pack(pady=6)

# state
selected_images = []
thumb_refs = []  # keep references to PhotoImage
selected_sensor_file = None

list_frame = tk.Frame(root)
list_frame.pack(fill="x", padx=12)

# images panel
images_panel = tk.LabelFrame(list_frame, text="Selected Images (multi)", padx=6, pady=6)
images_panel.pack(side="left", fill="both", expand=True, padx=8, pady=4)

images_listbox = tk.Listbox(images_panel, width=50, height=10)
images_listbox.pack(side="left", padx=6, pady=6)

thumb_canvas = tk.Canvas(images_panel, width=160, height=120)
thumb_canvas.pack(side="right", padx=6)

# sensor panel
sensor_panel = tk.LabelFrame(list_frame, text="Sensor file (single)", padx=6, pady=6)
sensor_panel.pack(side="left", fill="both", expand=True, padx=8, pady=4)

sensor_label = tk.Label(sensor_panel, text="No sensor file selected", width=40, anchor="w")
sensor_label.pack(padx=6, pady=12)

# output box
output_box = tk.Text(root, height=18, width=120, font=("Consolas", 10))
output_box.pack(padx=12, pady=12)

def refresh_thumb():
    thumb_canvas.delete("all")
    thumb_refs.clear()
    if selected_images:
        try:
            img = Image.open(selected_images[0])
            img.thumbnail(UPLOAD_PREVIEW_SIZE)
            ph = ImageTk.PhotoImage(img)
            thumb_refs.append(ph)
            thumb_canvas.create_image(80,60, image=ph)
        except Exception:
            pass

def pick_images():
    global selected_images
    files = filedialog.askopenfilenames(title="Select images", filetypes=[("Images","*.jpg *.jpeg *.png")])
    if not files:
        return
    selected_images = list(files)
    images_listbox.delete(0, tk.END)
    for f in selected_images:
        images_listbox.insert(tk.END, os.path.basename(f))
    refresh_thumb()

def pick_sensor():
    global selected_sensor_file
    path = filedialog.askopenfilename(title="Select sensor CSV", filetypes=[("CSV","*.csv")])
    if not path:
        return
    selected_sensor_file = path
    sensor_label.config(text=os.path.basename(path))

def send_images():
    if not selected_images:
        messagebox.showinfo("Info", "Please select images first.")
        return
    files = []
    for p in selected_images:
        try:
            files.append(("images[]", (os.path.basename(p), open(p, "rb"), "image/jpeg")))
        except Exception as e:
            messagebox.showerror("Error", f"Failed to open {p}: {e}")
            return
    try:
        resp = requests.post(BASE_URL + "/api/predict_potholes", files=files, timeout=30)
        text = resp.text
        try:
            j = resp.json()
            output_box.delete(1.0, tk.END)
            output_box.insert(tk.END, json.dumps(j, indent=2))
        except Exception:
            messagebox.showerror("Error", f"Invalid JSON response:\n{text}")
    except Exception as e:
        messagebox.showerror("Error", f"Request failed: {e}")

def send_sensor():
    global selected_sensor_file
    if not selected_sensor_file:
        messagebox.showinfo("Info", "Please select a sensor CSV first.")
        return
    try:
        with open(selected_sensor_file, "rb") as fh:
            files = {"sensor_file": (os.path.basename(selected_sensor_file), fh, "text/csv")}
            resp = requests.post(BASE_URL + "/api/analyze_surface", files=files, timeout=30)
            try:
                j = resp.json()
                output_box.delete(1.0, tk.END)
                output_box.insert(tk.END, json.dumps(j, indent=2))
            except Exception:
                messagebox.showerror("Error", "Invalid JSON from server:\n" + resp.text)
    except Exception as e:
        messagebox.showerror("Error", f"Failed to read file: {e}")

def check_status():
    try:
        resp = requests.get(BASE_URL + "/")
        j = resp.json()
        output_box.delete(1.0, tk.END)
        output_box.insert(tk.END, json.dumps(j, indent=2))
    except Exception as e:
        messagebox.showerror("Error", f"Request failed: {e}")

# buttons
tk.Button(btn_frame, text="Pick Images", width=16, command=pick_images).grid(row=0,column=0,padx=6)
tk.Button(btn_frame, text="Pick Sensor CSV", width=16, command=pick_sensor).grid(row=0,column=1,padx=6)
tk.Button(btn_frame, text="Upload Images & Predict", width=20, command=send_images).grid(row=0,column=2,padx=6)
tk.Button(btn_frame, text="Upload Sensor & Analyze", width=20, command=send_sensor).grid(row=0,column=3,padx=6)
tk.Button(btn_frame, text="Check API Status", width=16, command=check_status).grid(row=0,column=4,padx=6)

root.mainloop()
