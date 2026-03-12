import { Router } from 'express';
import { DataService } from '../services/data.service';

const router = Router();

router.get('/recommendations', async (req, res) => {
    try {
        const data = await DataService.getRecommendations();
        res.json(data);
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

router.get('/history', async (req, res) => {
    try {
        const data = await DataService.getHistory();
        res.json(data);
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

router.get('/me', async (req, res) => {
    try {
        const data = await DataService.getMe();
        res.json(data);
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

router.post('/refresh', async (req, res) => {
    try {
        await DataService.refreshCache();
        res.json({ message: "Data cache refreshed successfully" });
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

export default router;
