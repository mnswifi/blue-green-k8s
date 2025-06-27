from flask import Flask
import os

app = Flask(__name__)

COLOR = os.environ.get("COLOR", "blue")

@app.route("/")
def index():
    return f"Hello from {COLOR} deployment!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)