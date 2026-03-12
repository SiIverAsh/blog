import { Router } from 'express';
import dataRoutes from './data.routes';
import postsRoutes from './posts.routes';

const router = Router();

router.use('/', dataRoutes);
router.use('/posts', postsRoutes);

export default router;
