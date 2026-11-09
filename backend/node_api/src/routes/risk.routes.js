import { Router } from 'express';
import { analyze, listReports } from '../controllers/risk.controller.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.post('/analyze', requireAuth, analyze);
router.get('/reports', requireAuth, listReports);

export default router;
