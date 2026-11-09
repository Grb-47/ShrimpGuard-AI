"""Health endpoints."""

from fastapi import APIRouter

from app.config import settings

router = APIRouter(tags=["health"])


@router.get("/health")
def health():
    return {
        "status": "ok",
        "service": "shrimguard-risk-service",
        "version": "0.1.0",
        "gemini_configured": bool(settings.gemini_api_key and settings.gemini_model),
        "thresholds_configured": bool(settings.thresholds),
    }
