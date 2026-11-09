import { AppError } from '../middleware/errorHandler.js';

export async function listPonds(req, res, next) {
  next(new AppError('Pond listing is not implemented in the Week 02 foundation', 501));
}

export async function createPond(req, res, next) {
  next(new AppError('Pond creation is not implemented in the Week 02 foundation', 501));
}
