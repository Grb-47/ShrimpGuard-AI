"""Historical trend analysis for water-quality parameters."""

from collections import defaultdict

import numpy as np

from app.schemas.risk import HistoryPoint, TrendFinding

MIN_POINTS_FOR_TREND = 3


def analyze_trends(history: list[HistoryPoint]) -> list[TrendFinding]:
    grouped: dict[str, list[HistoryPoint]] = defaultdict(list)

    for point in history:
        grouped[point.parameter].append(point)

    findings: list[TrendFinding] = []

    for parameter, points in grouped.items():
        ordered = sorted(points, key=lambda item: item.recorded_at)

        if len(ordered) < MIN_POINTS_FOR_TREND:
            findings.append(
                TrendFinding(
                    parameter=parameter,
                    direction="insufficient_data",
                    message=(
                        f"At least {MIN_POINTS_FOR_TREND} points are required "
                        f"for a {parameter} trend."
                    ),
                )
            )
            continue

        values = np.array([point.value for point in ordered], dtype=float)
        indices = np.arange(len(values), dtype=float)
        slope = float(np.polyfit(indices, values, 1)[0])

        if abs(slope) < 1e-6:
            direction = "stable"
            message = f"{parameter} is stable across the provided history."
        elif slope > 0:
            direction = "rising"
            message = f"{parameter} is rising across the provided history."
        else:
            direction = "falling"
            message = f"{parameter} is falling across the provided history."

        findings.append(
            TrendFinding(
                parameter=parameter,
                direction=direction,
                change_per_sample=round(slope, 6),
                message=message,
            )
        )

    return findings
