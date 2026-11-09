import { Router } from 'express';
import { listFarms, createFarm } from '../controllers/farm.controller.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.get('/', requireAuth, listFarms);
router.post('/', requireAuth, createFarm);

export default router;
