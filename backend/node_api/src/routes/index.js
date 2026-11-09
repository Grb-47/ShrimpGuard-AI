import { Router } from 'express';
import healthRoutes from './health.routes.js';
import authRoutes from './auth.routes.js';
import farmerRoutes from './farmer.routes.js';
import farmRoutes from './farm.routes.js';
import pondRoutes from './pond.routes.js';
import deviceRoutes from './device.routes.js';
import readingRoutes from './reading.routes.js';
import riskRoutes from './risk.routes.js';
import notificationRoutes from './notification.routes.js';

const router = Router();

router.use('/health', healthRoutes);
router.use('/auth', authRoutes);
router.use('/farmers', farmerRoutes);
router.use('/farms', farmRoutes);
router.use('/ponds', pondRoutes);
router.use('/devices', deviceRoutes);
router.use('/readings', readingRoutes);
router.use('/risk', riskRoutes);
router.use('/notifications', notificationRoutes);

export default router;
