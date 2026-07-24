FROM python:3.11-slim

WORKDIR /app

ENV PORT=10000
ENV PYTHONUNBUFFERED=1

# Install Zoo during the image build, avoiding uvx downloads during
# ChatGPT's connection attempt.
RUN pip install --no-cache-dir "zoo-mcp==0.18.1"

COPY server_http.py /app/server_http.py

EXPOSE 10000

CMD ["python", "/app/server_http.py"]