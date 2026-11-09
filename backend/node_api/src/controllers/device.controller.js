import { AppError } from '../middleware/errorHandler.js';

export async function listDevices(req, res, next) {
  next(new AppError('Device listing is not implemented in the Week 02 foundation', 501));
}

export async function registerDevice(req, res, next) {
  next(new AppError('Device registration is not implemented in the Week 02 foundation', 501));
}
