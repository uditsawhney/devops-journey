# ---------------------------------------------------------------------------
# Dockerfile: the recipe Docker follows to build an "image" of our app.
# An image is a frozen, portable snapshot containing our code + Python + Flask.
# A running instance of an image is called a "container".
# ---------------------------------------------------------------------------

# 1. BASE IMAGE
# Start from an official, slim Python image instead of building Python ourselves.
# "3.12-slim" = Python 3.12 on a minimal Debian base (small = faster, safer).
FROM python:3.12-slim

# 2. METADATA (optional but good practice)
LABEL maintainer="uditsawhney"
LABEL description="DevOps Journey - Flask app"

# 3. ENVIRONMENT VARIABLES
# PYTHONDONTWRITEBYTECODE: don't write .pyc files (keeps the image clean).
# PYTHONUNBUFFERED: print logs straight to the terminal so we see them live.
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 4. WORKING DIRECTORY
# All following commands run inside /app. Docker creates it if missing.
WORKDIR /app

# 5. INSTALL DEPENDENCIES (this ordering is a key optimization)
# We copy ONLY requirements.txt first, then install. Because Docker caches each
# step ("layer"), dependencies are only re-installed when requirements.txt
# changes, not every time we edit app.py. This makes rebuilds much faster.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6. COPY THE APPLICATION CODE
# Now copy the rest of the project into the image.
COPY . .

# 7. DOCUMENT THE PORT
# Our Flask app listens on 5000. EXPOSE documents this (it doesn't publish it;
# we publish with -p when we run the container).
EXPOSE 5000

# 8. START COMMAND
# The command that runs when the container starts. Here we launch our app.
CMD ["python", "app.py"]
