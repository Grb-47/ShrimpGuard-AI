"""Risk analysis endpoints."""

from datetime import datetime, timezone

from fastapi import APIRouter

from app.config import settings
from app.rules.water_quality_rules import evaluate_readings
from app.schemas.risk import AnalyzeRequest, AnalyzeResponse
from app.services.anomaly_detection import detect_anomalies
from app.services.gemini_service import generate_bengali_explanation
from app.services.recommendation_service import build_recommendations
from app.services.risk_classifier import classify_risk
from app.services.trend_analysis import analyze_trends

router = APIRouter(tags=["risk"])


@router.post("/analyze", response_model=AnalyzeResponse)
async def analyze(payload: AnalyzeRequest) -> AnalyzeResponse:
    factors = evaluate_readings(payload.readings, settings.thresholds)
    trends = analyze_trends(payload.history)
    anomalies = detect_anomalies(payload.history)
    risk_level, risk_score, summary = classify_risk(factors)
    recommendations = build_recommendations(factors)

    explanation = None
    if risk_level is not None:
        explanation = await generate_bengali_explanation(
            risk_level=risk_level,
            summary=summary,
            factor_messages=[factor.message for factor in factors]
            + [anomaly.message for anomaly in anomalies],
        )

    return AnalyzeResponse(
        status="ok" if risk_level is not None else "not_configured",
        risk_level=risk_level,
        risk_score=risk_score,
        summary=summary,
        factors=factors,
        trends=trends,
        anomalies=anomalies,
        recommendations=recommendations,
        explanation_bn=explanation,
        analysis_engine="rules-v0",
        generated_at=datetime.now(timezone.utc),
    )
