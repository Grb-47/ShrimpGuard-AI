"""ShrimpGuard AI - FastAPI risk analysis service (foundation)."""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import settings
from app.routers import health, risk

app = FastAPI(
    title="ShrimpGuard AI Risk Analysis Service",
    description=(
        "Expert-rule, trend, and anomaly analysis for shrimp pond water quality. "
        "Gemini is used only to explain validated results in Bengali."
    ),
    version="0.1.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(health.router)
app.include_router(risk.router)


@app.get("/")
def root():
    return {
        "service": "shrimguard-risk-service",
        "version": "0.1.0",
        "docs": "/docs",
        "health": "/health",
    }
