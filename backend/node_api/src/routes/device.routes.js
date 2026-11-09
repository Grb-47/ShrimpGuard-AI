import { Router } from 'express';
import { listDevices, registerDevice } from '../controllers/device.controller.js';
import { requireAuth } from '../middleware/auth.js';

const router = Router();

router.get('/', requireAuth, listDevices);
router.post('/', requireAuth, registerDevice);

export default router;
