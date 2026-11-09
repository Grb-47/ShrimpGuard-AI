import { Router } from 'express';
import { listPonds, createPond } from '../controllers/pond.controller.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.get('/', requireAuth, listPonds);
router.post('/', requireAuth, createPond);

export default router;
