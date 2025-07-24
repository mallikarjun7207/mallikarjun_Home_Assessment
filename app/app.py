from flask import Flask, jsonify, request
import logging
import os
import socket
from datetime import datetime

app = Flask(__name__)

# Set up basic logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s %(message)s')
logger = logging.getLogger(__name__)

@app.before_request
def log_request_info():
    logger.info(f"Incoming request: {request.method} {request.path} from {request.remote_addr}")

@app.route('/')
def index():
    hostname = socket.gethostname()
    return jsonify({
        "message": "Welcome to the DevOps Assessment App!",
        "host": hostname,
        "timestamp": datetime.utcnow().isoformat() + 'Z'
    })

@app.route('/health')
def health():
    return jsonify({"status": "OK"})

@app.route('/metadata')
def metadata():
    return jsonify({
        "environment": os.getenv("ENVIRONMENT", "development"),
        "version": os.getenv("APP_VERSION", "1.0.0")
    })

if __name__ == '__main__':
    port = int(os.getenv("PORT", 8080))
    app.run(host='0.0.0.0', port=port)
