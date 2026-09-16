# DevOps Journey

A hands-on project that takes a simple web application through the **entire DevOps lifecycle**, built from scratch on self-hosted Ubuntu servers (no managed cloud required).

The application itself is deliberately tiny, a small Python/Flask web service. The real learning is in everything built *around* it: containers, CI/CD, infrastructure as code, orchestration, and monitoring.

---

## Why this project exists

I'm learning DevOps by doing. Instead of one big leap, this repo grows one phase at a time. Each phase adds a real, industry-standard practice and is committed separately, so the git history tells the story of the journey.

---

## The application

| Endpoint  | Purpose                                        |
|-----------|------------------------------------------------|
| `/`       | Landing page, confirms the app is running       |
| `/health` | Health check used by load balancers / k8s / monitoring |

Stack: **Python 3 + Flask**.

---

## Roadmap

| Phase | Focus | Tools | Status |
|-------|-------|-------|--------|
| 0 | App + repo hygiene | Flask, Git, pytest | ✅ Done |
| 1 | Containerization | Docker | ✅ Done |
| 2 | Continuous Integration | GitHub Actions | ⬜ Planned |
| 3 | Continuous Deployment | GitHub Actions + SSH | ⬜ Planned |
| 4 | Infrastructure as Code | Terraform + Ansible | ⬜ Planned |
| 5 | Orchestration | Kubernetes (k3s) | ⬜ Planned |
| 6 | Monitoring & Observability | Prometheus + Grafana | ⬜ Planned |

---

## Running the app locally

Requires Python 3.10+.

```bash
# 1. Create and activate a virtual environment
python -m venv venv
# Windows:
venv\Scripts\activate
# Linux/macOS:
source venv/bin/activate

# 2. Install dependencies
pip install -r requirements.txt

# 3. Run the app
python app.py
```

Then open http://localhost:5000 in your browser. You should see a JSON greeting.

## Running the tests

```bash
pytest -v
```

---

## Project structure

```
devops-journey/
├── app.py            # The Flask application
├── test_app.py       # Automated tests (run by CI in Phase 2)
├── requirements.txt  # Python dependencies
├── Dockerfile        # Recipe to build the app into a container image
├── .dockerignore     # Files excluded from the Docker image
├── .gitignore        # Files git should never track
└── README.md         # You are here
```

---

## Phase 1: Running with Docker

Build the image (the `-t` flag tags it with a name):

```bash
docker build -t devops-journey:latest .
```

Run a container from the image (`-p` maps host port 5000 to container port 5000, `-d` runs it in the background):

```bash
docker run -d -p 5000:5000 --name devops-journey-app devops-journey:latest
```

Verify it works:

```bash
curl http://localhost:5000/
curl http://localhost:5000/health
```

Useful commands:

```bash
docker ps                          # list running containers
docker logs devops-journey-app     # view app logs
docker stop devops-journey-app     # stop the container
docker rm devops-journey-app       # remove the container
```

---

*This README will grow as each phase is completed.*
