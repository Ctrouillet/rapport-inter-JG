FROM python:3.11-slim

# Installer uniquement LibreOffice Writer (pas la suite complète)
RUN apt-get update && apt-get install -y \
    libreoffice-writer \
    fonts-liberation \
    fonts-dejavu \
    --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=5000
EXPOSE 5000

CMD gunicorn rapport_generator_final_v2:app --bind 0.0.0.0:$PORT --timeout 120 --workers 1
