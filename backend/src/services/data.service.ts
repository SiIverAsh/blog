import { prisma } from '../lib/prisma';

export class DataService {
    static async getRecommendations() {
        try {
            const latest = await prisma.recommendation.findFirst({
                orderBy: { createdAt: 'desc' }
            });
            return latest || {};
        } catch (e) {
            console.error("Error fetching recommendations from DB:", e);
            return {};
        }
    }

    static async getHistory() {
        try {
            // Get last 10 days of history logs
            const logs = await prisma.historyLog.findMany({
                orderBy: { date: 'desc' },
                take: 10
            });
            
            // Let's return the latest recommendation's history field by default
            const latestRec = await prisma.recommendation.findFirst({
                orderBy: { createdAt: 'desc' }
            });
            return latestRec?.history || [];
        } catch (e) {
            console.error("Error fetching history from DB:", e);
            return [];
        }
    }

    static async getMe() {
        try {
            const me = await prisma.meInfo.findUnique({
                where: { id: 1 }
            });
            return me?.content || {};
        } catch (e) {
            console.error("Error fetching me info from DB:", e);
            return {};
        }
    }

    static async refreshCache() {
        // DB is live
    }
}
