import { AppError } from '../middleware/errorHandler.js';

export async function listNotifications(req, res, next) {
  next(new AppError('Notification listing is not implemented in the Week 02 foundation', 501));
}
