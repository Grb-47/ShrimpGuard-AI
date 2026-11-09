"""Request and response schemas for risk analysis."""

from datetime import datetime
from typing import Any, Literal
from uuid import UUID

from pydantic import BaseModel, Field

ParameterName = Literal["ph", "dissolved_oxygen", "temperature", "salinity", "ammonia"]
FactorStatus = Literal["normal", "below_range", "above_range", "not_configured"]
RiskLevel = Literal["low", "moderate", "high", "critical"]
Priority = Literal["low", "medium", "high", "urgent"]


class ParameterReading(BaseModel):
    value: float
    unit: str | None = None
    recorded_at: datetime | None = None
    source: Literal["sensor", "manual"] | None = None


class HistoryPoint(BaseModel):
    parameter: str
    value: float
    recorded_at: datetime


class AnalyzeRequest(BaseModel):
    pond_id: UUID | None = None
    readings: dict[str, ParameterReading] = Field(default_factory=dict)
    history: list[HistoryPoint] = Field(default_factory=list)
    pond_context: dict[str, Any] = Field(default_factory=dict)
    language: str = "bn"


class RiskFactor(BaseModel):
    parameter: str
    value: float | None = None
    unit: str | None = None
    status: FactorStatus
    message: str


class TrendFinding(BaseModel):
    parameter: str
    direction: Literal["rising", "falling", "stable", "insufficient_data"]
    change_per_sample: float | None = None
    message: str


class AnomalyFinding(BaseModel):
    parameter: str
    value: float
    method: str
    z_score: float | None = None
    message: str


class RecommendationItem(BaseModel):
    title: str
    description_bn: str
    priority: Priority
    category: str


class AnalyzeResponse(BaseModel):
    status: Literal["ok", "not_configured"]
    risk_level: RiskLevel | None = None
    risk_score: float | None = None
    summary: str
    factors: list[RiskFactor]
    trends: list[TrendFinding]
    anomalies: list[AnomalyFinding] = Field(default_factory=list)
    recommendations: list[RecommendationItem]
    explanation_bn: str | None = None
    analysis_engine: str = "rules-v0"
    generated_at: datetime
