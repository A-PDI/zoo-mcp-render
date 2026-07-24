FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && pip install --no-cache-dir uv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV PORT=10000
ENV PYTHONUNBUFFERED=1

EXPOSE 10000

CMD ["sh", "-c", "exec npx -y supergateway@3.4.3 --port \"$PORT\" --stdio \"uvx zoo-mcp\" --outputTransport streamableHttp --streamableHttpPath /mcp"]