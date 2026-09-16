"""
Automated tests for the Flask app.

Why tests matter for DevOps: in Phase 2 (CI), these run automatically on every
push. If a change breaks the app, the pipeline fails and stops the bad code from
ever reaching your server. This is how teams ship safely and often.
"""
import app as flask_app


def test_home_returns_ok():
    client = flask_app.app.test_client()
    response = client.get("/")
    assert response.status_code == 200
    assert response.get_json()["status"] == "ok"


def test_health_is_healthy():
    client = flask_app.app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "healthy"
