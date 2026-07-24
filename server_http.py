import os

from mcp.server.transport_security import TransportSecuritySettings
from starlette.requests import Request
from starlette.responses import JSONResponse
from zoo_mcp.server import mcp


# Configure Zoo's existing FastMCP instance for Render.
mcp.settings.host = "0.0.0.0"
mcp.settings.port = int(os.environ.get("PORT", "10000"))
mcp.settings.streamable_http_path = "/mcp"

# Recommended production HTTP behavior.
mcp.settings.stateless_http = True
mcp.settings.json_response = True

# Zoo creates the MCP object with localhost-only defaults.
# Replace those defaults with the public Render hostname.
mcp.settings.transport_security = TransportSecuritySettings(
    enable_dns_rebinding_protection=True,
    allowed_hosts=[
        "zoo-mcp-server.onrender.com",
        "zoo-mcp-server.onrender.com:*",
    ],
    allowed_origins=[
        "https://chatgpt.com",
        "https://chat.openai.com",
    ],
)


@mcp.custom_route("/health", methods=["GET"])
async def health(_: Request) -> JSONResponse:
    return JSONResponse({"status": "ok"})


if __name__ == "__main__":
    mcp.run(transport="streamable-http")