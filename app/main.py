from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

app = FastAPI()

@app.middleware("http")
async def extract_client_cert_info(request: Request, call_next):
    client_cert_subject = request.headers.get("X-SSL-Client-S-DN", "Unknown")
    request.state.client_cert_subject = client_cert_subject
    response = await call_next(request)
    return response

@app.get("/")
async def read_root(request: Request):
    return {
        "message": "Hello from mTLS protected API",
        "client_cert_subject": request.state.client_cert_subject
    }
