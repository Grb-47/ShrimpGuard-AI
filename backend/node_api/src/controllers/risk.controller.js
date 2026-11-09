import { AppError } from '../middleware/errorHandler.js';
import { analyzeRisk } from '../services/riskClient.service.js';

export async function analyze(req, res, next) {
  try {
    const result = await analyzeRisk(req.body);
    res.status(200).json(result);
  } catch (error) {
    next(error);
  }
}

export async function listReports(req, res, next) {
  next(new AppError('Risk report listing is not implemented in the Week 02 foundation', 501));
}
