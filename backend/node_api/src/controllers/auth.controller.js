import { AppError } from '../middleware/errorHandler.js';

export async function register(req, res, next) {
  next(new AppError('Farmer registration is not implemented in the Week 02 foundation', 501));
}

export async function login(req, res, next) {
  next(new AppError('Farmer login is not implemented in the Week 02 foundation', 501));
}
