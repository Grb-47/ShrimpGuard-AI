export class AppError extends Error {
  constructor(message, statusCode = 500, details = undefined) {
    super(message);
    this.name = 'AppError';
    this.statusCode = statusCode;
    this.details = details;
  }
}

export function notFoundHandler(req, res) {
  res.status(404).json({
    error: 'Not Found',
    message: `No route for ${req.method} ${req.originalUrl}`,
  });
}

export function errorHandler(error, req, res, _next) {
  const statusCode = error.statusCode || 500;
  const isProduction = process.env.NODE_ENV === 'production';

  if (statusCode >= 500) {
    console.error('[error]', error);
  }

  res.status(statusCode).json({
    error: error.name || 'Error',
    message: isProduction && statusCode >= 500 ? 'Internal server error' : error.message,
    ...(error.details ? { details: error.details } : {}),
  });
}
