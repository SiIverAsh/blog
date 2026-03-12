import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import morgan from 'morgan';
import cron from 'node-cron';
import { exec } from 'child_process';
import path from 'path';
import apiRoutes from './routes';
import { PostsService } from './services/posts.service';
import { DataService } from './services/data.service';

dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use(morgan('dev'));

app.use('/api', apiRoutes);

/* 
// Daily Automation Cron Job (Runs at 00:00 Every Day) - DISABLED FOR DEBUGGING
cron.schedule('0 0 * * *', () => {
    console.log('⏰ [Cron] Starting daily automation scripts...');
    const automationPath = path.resolve(__dirname, '../../run_automation.py');
    const seedPath = path.resolve(__dirname, './scripts/seed.ts');
    
    exec(`python "${automationPath}"`, (error, stdout, stderr) => {
        if (error) {
            console.error(`❌ [Cron] Automation Error: ${error.message}`);
            return;
        }
        console.log(`✅ [Cron] Automation Finished.`);

        console.log('🔄 [Cron] Syncing new data to PostgreSQL...');
        exec(`npx tsx "${seedPath}"`, (sError, sStdout, sStderr) => {
            if (sError) {
                console.error(`❌ [Cron] Sync Error: ${sError.message}`);
                return;
            }
            console.log('✨ [Cron] Database synced successfully.');
            
            PostsService.refreshCache();
            DataService.refreshCache();
        });
    });
});
*/

// Global Error Handler
app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Internal Server Error', message: err.message });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
