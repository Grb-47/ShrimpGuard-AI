"""Expert-rule evaluation scaffolding.

IMPORTANT:
No expert-validated thresholds are included in this repository yet.
Thresholds must be supplied through WATER_QUALITY_THRESHOLDS_JSON after
validation with a qualified aquaculture expert. When thresholds are absent,
the API returns status="not_configured" instead of inventing a risk level.
"""

from typing import Any

from app.schemas.risk import ParameterReading, RiskFactor

SUPPORTED_PARAMETERS = (
    "ph",
    "dissolved_oxygen",
    "temperature",
    "salinity",
    "ammonia",
)


def evaluate_readings(
    readings: dict[str, ParameterReading],
    thresholds: dict[str, dict[str, Any]],
) -> list[RiskFactor]:
    factors: list[RiskFactor] = []

    for parameter in SUPPORTED_PARAMETERS:
        reading = readings.get(parameter)
        if reading is None:
            continue

        config = thresholds.get(parameter)
        if not isinstance(config, dict):
            config = {}
        minimum = config.get("min")
        maximum = config.get("max")
        unit = reading.unit or config.get("unit")

        if minimum is None and maximum is None:
            factors.append(
                RiskFactor(
                    parameter=parameter,
                    value=reading.value,
                    unit=unit,
                    status="not_configured",
                    message=(
                        f"Threshold for {parameter} is not configured. "
                        "Expert validation is required."
                    ),
                )
            )
            continue

        if minimum is not None and reading.value < minimum:
            status = "below_range"
            message = f"{parameter} is below the configured minimum ({minimum})."
        elif maximum is not None and reading.value > maximum:
            status = "above_range"
            message = f"{parameter} is above the configured maximum ({maximum})."
        else:
            status = "normal"
            message = f"{parameter} is within the configured range."

        factors.append(
            RiskFactor(
                parameter=parameter,
                value=reading.value,
                unit=unit,
                status=status,
                message=message,
            )
        )

    return factors
