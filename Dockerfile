FROM python:3.11

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install system build dependencies and SSL certificates for MongoDB
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential \
       gcc \
       libffi-dev \
       libssl-dev \
       ca-certificates \
       openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy project from subfolder and install requirements
COPY logistik-bot/requirements.txt /app/requirements.txt
RUN pip install --upgrade pip setuptools wheel certifi \
    && pip install --no-cache-dir -r /app/requirements.txt

COPY logistik-bot/ /app

CMD ["python", "main.py"]
