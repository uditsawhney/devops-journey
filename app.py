"""
A tiny Flask web application.

This is intentionally simple. The point of this project is not the app itself,
it is everything we build *around* the app: containers, CI/CD, infrastructure,
orchestration, and monitoring. The app just gives us something real to ship.
"""
from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def home():
    """Landing page. Confirms the app is alive."""
    return jsonify(
        message="Hello from the DevOps Journey app!",
        status="ok",
    )


@app.route("/health")
def health():
    """
    Health check endpoint.

    Load balancers, Kubernetes, and monitoring tools ping an endpoint like this
    to decide if the app is healthy. We will use it in later phases.
    """
    return jsonify(status="healthy"), 200


if __name__ == "__main__":
    # host="0.0.0.0" makes the app reachable from outside the container/server,
    # not just localhost. Port 5000 is Flask's default.
    app.run(host="0.0.0.0", port=5000)
