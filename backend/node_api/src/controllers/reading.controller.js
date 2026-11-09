import { AppError } from '../middleware/errorHandler.js';

export async function createReading(req, res, next) {
  next(new AppError('Sensor reading ingestion is not implemented in the Week 02 foundation', 501));
}

export async function createManualReading(req, res, next) {
  next(new AppError('Manual reading entry is not implemented in the Week 02 foundation', 501));
}

export async function listHistory(req, res, next) {
  next(new AppError('Historical data retrieval is not implemented in the Week 02 foundation', 501));
}
