"""Abnormal pattern detection for historical readings.

The z-score method below is a FOUNDATION detector and requires domain review.
It flags the latest point when it is far from the provided history mean. No
threshold is invented for water-quality safety; this only detects statistical
outliers, not environmental risk.
"""

from collections import defaultdict

import numpy as np

from app.schemas.risk import AnomalyFinding, HistoryPoint

MIN_POINTS_FOR_ANOMALY = 5
Z_SCORE_THRESHOLD = 3.0


def detect_anomalies(history: list[HistoryPoint]) -> list[AnomalyFinding]:
    grouped: dict[str, list[HistoryPoint]] = defaultdict(list)

    for point in history:
        grouped[point.parameter].append(point)

    findings: list[AnomalyFinding] = []

    for parameter, points in grouped.items():
        ordered = sorted(points, key=lambda item: item.recorded_at)

        if len(ordered) < MIN_POINTS_FOR_ANOMALY:
            continue

        values = np.array([point.value for point in ordered], dtype=float)
        std_dev = float(np.std(values, ddof=1))

        if std_dev == 0:
            continue

        mean = float(np.mean(values))
        latest = ordered[-1]
        z_score = float((latest.value - mean) / std_dev)

        if abs(z_score) >= Z_SCORE_THRESHOLD:
            findings.append(
                AnomalyFinding(
                    parameter=parameter,
                    value=latest.value,
                    method="z-score",
                    z_score=round(z_score, 3),
                    message=(
                        f"{parameter} latest value is a statistical outlier "
                        f"(z-score {z_score:.2f}); verify the sensor and reading."
                    ),
                )
            )

    return findings
