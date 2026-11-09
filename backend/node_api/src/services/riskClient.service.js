import { env } from '../config/env.js';
import { AppError } from '../middleware/errorHandler.js';

const REQUEST_TIMEOUT_MS = 15_000;

export async function analyzeRisk(payload) {
  if (!env.riskServiceUrl) {
    throw new AppError('RISK_SERVICE_URL is not configured', 503);
  }

  const baseUrl = env.riskServiceUrl.replace(/\/+$/, '');
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), REQUEST_TIMEOUT_MS);

  try {
    const response = await fetch(`${baseUrl}/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload),
      signal: controller.signal,
    });

    const data = await response.json().catch(() => ({}));

    if (!response.ok) {
      throw new AppError('Risk analysis service returned an error', 502, data);
    }

    return data;
  } catch (error) {
    if (error.name === 'AbortError') {
      throw new AppError('Risk analysis service timed out', 504);
    }
    if (error instanceof AppError) {
      throw error;
    }
    throw new AppError('Risk analysis service is unavailable', 503);
  } finally {
    clearTimeout(timeout);
  }
}
