"""Application configuration for the ShrimpGuard AI risk service."""

import json
import os
from dataclasses import dataclass, field
from typing import Any

from dotenv import load_dotenv

load_dotenv()


def _parse_thresholds(raw: str) -> dict[str, dict[str, Any]]:
    """Parse optional threshold JSON. Invalid input yields an empty map."""
    if not raw.strip():
        return {}
    try:
        parsed = json.loads(raw)
    except json.JSONDecodeError:
        return {}
    return parsed if isinstance(parsed, dict) else {}


@dataclass(frozen=True)
class Settings:
    app_env: str = os.getenv("APP_ENV", "development")
    port: int = int(os.getenv("PORT", "8000"))
    database_url: str = os.getenv("DATABASE_URL", "")
    gemini_api_key: str = os.getenv("GEMINI_API_KEY", "")
    gemini_model: str = os.getenv("GEMINI_MODEL", "")
    cors_origins: list[str] = field(
        default_factory=lambda: [
            origin.strip()
            for origin in os.getenv(
                "CORS_ORIGIN", "http://localhost:3000,http://localhost:5173"
            ).split(",")
            if origin.strip()
        ]
    )
    thresholds: dict[str, dict[str, Any]] = field(
        default_factory=lambda: _parse_thresholds(
            os.getenv("WATER_QUALITY_THRESHOLDS_JSON", "")
        )
    )


settings = Settings()
