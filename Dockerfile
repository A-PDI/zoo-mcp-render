FROM python:3.11-slim

# Install Node.js (for supergateway bridge) and uv (for zoo-mcp execution)
RUN apt-get update && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && pip install uv

WORKDIR /app

# Render passes its assigned HTTP port via $PORT
ENV PORT=10000
EXPOSE $PORT

# Run supergateway to wrap `uvx zoo-mcp` into an SSE server
CMD ["sh", "-c", "npx -y supergateway --port $PORT --stdio \"uvx zoo-mcp\""]
