import { AppError } from '../middleware/errorHandler.js';

export async function getProfile(req, res, next) {
  next(new AppError('Farmer profile retrieval is not implemented in the Week 02 foundation', 501));
}

export async function updateProfile(req, res, next) {
  next(new AppError('Farmer profile update is not implemented in the Week 02 foundation', 501));
}
