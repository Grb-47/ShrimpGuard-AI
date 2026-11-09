import { Router } from 'express';
import {
  createReading,
  createManualReading,
  listHistory,
} from '../controllers/reading.controller.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.post('/', requireAuth, createReading);
router.post('/manual', requireAuth, createManualReading);
router.get('/history', requireAuth, listHistory);

export default router;
