"""Gemini explanation and recommendation layer.

Gemini explains a structured risk result and drafts practical recommendations in
Bengali. It is not allowed to perform or replace risk classification. If the key
or model is not configured, the service returns None and the rule-based result
is still preserved.
"""

import httpx

from app.config import settings

GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models"


async def generate_bengali_explanation(
    risk_level: str,
    summary: str,
    factor_messages: list[str],
) -> str | None:
    if not settings.gemini_api_key or not settings.gemini_model:
        return None

    prompt = (
        "You are explaining a shrimp pond water-quality risk report to a farmer "
        "in Bangladesh and drafting practical recommendations. Use simple Bengali "
        "with two short sections: 'ব্যাখ্যা' (explanation) and 'পরামর্শ' "
        "(recommendations). Do not invent measurements, do not change the risk "
        "level, and do not give chemical dosing instructions. Recommend verifying "
        "the readings and consulting a local aquaculture expert when needed.\n\n"
        f"Risk level: {risk_level}\n"
        f"Summary: {summary}\n"
        f"Factors: {'; '.join(factor_messages) if factor_messages else 'None'}"
    )

    url = f"{GEMINI_ENDPOINT}/{settings.gemini_model}:generateContent"

    try:
        async with httpx.AsyncClient(timeout=20.0) as client:
            response = await client.post(
                url,
                params={"key": settings.gemini_api_key},
                json={
                    "contents": [{"parts": [{"text": prompt}]}],
                    "generationConfig": {"temperature": 0.2},
                },
            )
            response.raise_for_status()
            payload = response.json()
    except (httpx.HTTPError, ValueError):
        return None

    candidates = payload.get("candidates") or []
    if not candidates:
        return None

    content = candidates[0].get("content") or {}
    parts = content.get("parts") or []
    text = "".join(part.get("text", "") for part in parts).strip()
    return text or None
