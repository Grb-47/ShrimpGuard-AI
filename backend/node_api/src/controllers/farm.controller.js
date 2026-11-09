import { AppError } from '../middleware/errorHandler.js';

export async function listFarms(req, res, next) {
  next(new AppError('Farm listing is not implemented in the Week 02 foundation', 501));
}

export async function createFarm(req, res, next) {
  next(new AppError('Farm creation is not implemented in the Week 02 foundation', 501));
}
