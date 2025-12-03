# gui_api_client.py  (FINAL CLEAN VERSION — NO FLASK SERVER HERE)
import os
import requests
import json
import tkinter as tk
from tkinter import filedialog, messagebox
from PIL import Image, ImageTk

BASE_URL = "http://127.0.0.1:5000"

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
os.makedirs(DATA_DIR, exist_ok=True)

UPLOAD_PREVIEW_SIZE = (140, 100)

selected_images = []
selected_sensor_file = None
thumb_refs = []


# ----------------------------------------------------
# GUI SETUP
# ----------------------------------------------------
root = tk.Tk()
root.title("AI Smart Road Monitoring - API GUI")
root.geometry("1120x680")

tk.Label(root, text="AI Smart Road Monitoring - API GUI",
         font=("Segoe UI", 20, "bold"), fg="#004a8f").pack(pady=10)

btn_frame = tk.Frame(root)
btn_frame.pack(pady=5)

# Middle panel
frame_mid = tk.Frame(root)
frame_mid.pack(fill="x", padx=10)

# Image panel
img_panel = tk.LabelFrame(frame_mid, text="Selected Images", padx=6, pady=6)
img_panel.pack(side="left", fill="both", expand=True)

sensor_panel = tk.LabelFrame(frame_mid, text="Sensor CSV", padx=6, pady=6)
sensor_panel.pack(side="left", fill="both", expand=True)

output_box = tk.Text(root, height=18, width=130, font=("Consolas", 10))
output_box.pack(pady=12)

images_list = tk.Listbox(img_panel, width=45, height=12)
images_list.pack(side="left", padx=10)

thumb_canvas = tk.Canvas(img_panel, width=160, height=120, bg="white")
thumb_canvas.pack(side="right")

sensor_label = tk.Label(sensor_panel, text="No sensor selected", width=30, anchor="w")
sensor_label.pack(pady=20)


# ----------------------------------------------------
# Utilities
# ----------------------------------------------------
def show_thumb():
    thumb_canvas.delete("all")
    thumb_refs.clear()
    if not selected_images:
        return

    try:
        im = Image.open(selected_images[0])
        im.thumbnail(UPLOAD_PREVIEW_SIZE)
        ph = ImageTk.PhotoImage(im)
        thumb_refs.append(ph)
        thumb_canvas.create_image(80, 60, image=ph)
    except:
        pass


def pick_images():
    global selected_images
    files = filedialog.askopenfilenames(filetypes=[("Images", "*.jpg *.png *.jpeg")])
    if not files:
        return

    selected_images = list(files)
    images_list.delete(0, tk.END)

    for f in selected_images:
        images_list.insert(tk.END, os.path.basename(f))

    show_thumb()


def pick_sensor():
    global selected_sensor_file
    path = filedialog.askopenfilename(filetypes=[("CSV Files", "*.csv")])
    if not path:
        return

    selected_sensor_file = path
    sensor_label.config(text=os.path.basename(path))


def safe_json(resp):
    try:
        return json.dumps(resp.json(), indent=2)
    except:
        return resp.text


def send_images():
    if not selected_images:
        messagebox.showinfo("Info", "No images selected")
        return

    files = []
    for p in selected_images:
        files.append(("images[]", (os.path.basename(p), open(p, "rb"), "image/jpeg")))

    try:
        r = requests.post(BASE_URL + "/api/predict_potholes", files=files, timeout=20)
        output_box.delete(1.0, tk.END)
        output_box.insert(tk.END, safe_json(r))
    except Exception as e:
        messagebox.showerror("Error", f"Request failed:\n{e}")


def send_sensor():
    if not selected_sensor_file:
        messagebox.showinfo("Info", "No sensor CSV selected")
        return

    try:
        files = {"sensor_file": (os.path.basename(selected_sensor_file),
                                 open(selected_sensor_file, "rb"),
                                 "text/csv")}
        r = requests.post(BASE_URL + "/api/analyze_surface", files=files, timeout=20)
        output_box.delete(1.0, tk.END)
        output_box.insert(tk.END, safe_json(r))
    except Exception as e:
        messagebox.showerror("Error", f"Request failed:\n{e}")


def check_status():
    try:
        r = requests.get(BASE_URL + "/", timeout=5)
        output_box.delete(1.0, tk.END)
        output_box.insert(tk.END, safe_json(r))
    except Exception as e:
        messagebox.showerror("Error", f"Request failed:\n{e}")


# ----------------------------------------------------
# Buttons
# ----------------------------------------------------
tk.Button(btn_frame, text="Pick Images", width=16, command=pick_images).grid(row=0, column=0, padx=5)
tk.Button(btn_frame, text="Pick Sensor CSV", width=16, command=pick_sensor).grid(row=0, column=1, padx=5)
tk.Button(btn_frame, text="Upload Images & Predict", width=20, command=send_images).grid(row=0, column=2, padx=5)
tk.Button(btn_frame, text="Upload Sensor & Analyze", width=20, command=send_sensor).grid(row=0, column=3, padx=5)
tk.Button(btn_frame, text="Check API Status", width=16, command=check_status).grid(row=0, column=4, padx=5)

root.mainloop()
