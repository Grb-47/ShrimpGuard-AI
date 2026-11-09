import { Router } from 'express';
import { checkDatabaseConnection } from '../config/db.js';

const router = Router();

router.get('/', async (req, res) => {
  const database = await checkDatabaseConnection();

  res.status(200).json({
    status: 'ok',
    service: 'shrimguard-node-api',
    version: '0.1.0',
    database: database.connected ? 'connected' : 'not_connected',
    timestamp: new Date().toISOString(),
  });
});

export default router;
