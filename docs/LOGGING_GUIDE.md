# Logging and redaction guide (service implementers)

Defaults:
- Use structured JSON logging.
- Apply redaction middleware to strip tokens, secrets, and PII.
- Include `request_id`/trace ids and SPIFFE IDs (if mTLS) for correlation.

Python pattern (FastAPI/Starlette):
```python
from starlette.middleware.base import BaseHTTPMiddleware
import json, logging

SENSITIVE_HEADERS = {"authorization", "cookie", "x-api-key"}

class RedactMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        # Remove sensitive headers
        headers = {k: v for k, v in request.headers.items() if k.lower() not in SENSITIVE_HEADERS}
        request.state.request_id = request.headers.get("x-request-id")
        response = await call_next(request)
        # Emit minimal log
        logging.info(json.dumps({
            "ts": datetime.utcnow().isoformat() + "Z",
            "event": "http.access",
            "service": "your-service",
            "request_id": request.state.request_id,
            "path": request.url.path,
            "method": request.method,
            "status": response.status_code,
            "client_ip": request.client.host if ALLOW_CLIENT_IP else None,
        }))
        return response
```

Guidance:
- Log decisions, not payloads: include classification/consent/policy result rather than full data.
- Mask identifiers for highly-sensitive resources; log hashes or lengths.
- Separate access logs from audit logs; route audit logs to an immutable sink.
- Avoid client IP logging when deployments require stricter privacy; if logged, avoid long retention.

Alerting:
- Use counters for auth failures, policy.denied, actuation.denied; wire thresholds in the monitoring backend (e.g., Prometheus + Alertmanager).
- Emit explicit error events for signature verification failures (images/policy bundles) and treat as critical.
