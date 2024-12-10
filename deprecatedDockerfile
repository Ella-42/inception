# Fetch python
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Copy over files to working directory
COPY . /app

# Setup minimal HTTP server over port 8000
CMD ["python", "-m", "http.server", "8000", "--bind", "127.0.0.1"]
