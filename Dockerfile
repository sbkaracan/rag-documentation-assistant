# 1. Base image
FROM python:3.11-slim

# 2. Set working directory
WORKDIR /app

# 3. Install system dependencies (if needed)
# (You may add build tools or OS libs here if Chromadb or PyPDF needs them)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 4. Copy requirements and install deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copy the rest of the code
COPY . .

# 6. Streamlit config (optional: avoid usage stats noise)
ENV STREAMLIT_TELEMETRY="false"

# 7. Expose Streamlit default port
EXPOSE 8501

# 8. Entrypoint: run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]