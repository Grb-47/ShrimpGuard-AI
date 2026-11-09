"""Risk classification from evaluated factors.

The scoring policy below is a FOUNDATION policy and requires expert review.
It never invents thresholds: it only scores factors that were evaluated using
configured, externally supplied thresholds.
"""

from typing import Literal

from app.schemas.risk import RiskFactor

RiskLevel = Literal["low", "moderate", "high", "critical"]

OUT_OF_RANGE_PENALTY = 30
MAX_SCORE = 100


def classify_risk(
    factors: list[RiskFactor],
) -> tuple[RiskLevel | None, float | None, str]:
    configured = [factor for factor in factors if factor.status != "not_configured"]

    if not configured:
        return (
            None,
            None,
            (
                "No expert-validated thresholds are configured, so risk "
                "classification was skipped. Provide thresholds before "
                "presenting a risk level to farmers."
            ),
        )

    out_of_range = [
        factor
        for factor in configured
        if factor.status in ("below_range", "above_range")
    ]

    score = float(min(MAX_SCORE, len(out_of_range) * OUT_OF_RANGE_PENALTY))

    if score >= 75:
        level: RiskLevel = "critical"
    elif score >= 50:
        level = "high"
    elif score >= 25:
        level = "moderate"
    else:
        level = "low"

    unconfigured = len(factors) - len(configured)
    summary_parts = [
        f"{len(out_of_range)} parameter(s) are outside configured ranges.",
        f"Foundation risk score: {score:.0f}/100.",
    ]
    if unconfigured:
        summary_parts.append(
            f"{unconfigured} parameter(s) could not be evaluated because "
            "thresholds are not configured."
        )

    return level, score, " ".join(summary_parts)
