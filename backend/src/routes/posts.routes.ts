import { Router } from 'express';
import { PostsService } from '../services/posts.service';

const router = Router();

router.get('/', async (req, res) => {
    try {
        const { category } = req.query;
        let posts = await PostsService.getAllPosts();
        
        if (category) {
            posts = posts.filter((post: any) => {
                const cats = post.categories || [];
                return cats.includes(category as string);
            });
        }
        
        // Remove 'content' to save bandwidth for list view
        const listPosts = posts.map(({ content, ...rest }: any) => rest);
        res.json(listPosts);
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

router.get('/search', async (req, res) => {
    try {
        const { q } = req.query;
        const results = await PostsService.searchPosts(q as string || '');
        const listResults = results.map(({ content, ...rest }: any) => rest);
        res.json(listResults);
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

router.get('/:id', async (req, res) => {
    try {
        const post = await PostsService.getPostById(req.params.id);
        if (!post) {
            return res.status(404).json({ error: "Post not found" });
        }
        res.json(post);
    } catch (e: any) {
        res.status(500).json({ error: e.message });
    }
});

router.post('/refresh', async (req, res) => {
    await PostsService.refreshCache();
    res.json({ message: "Posts cache refreshed successfully" });
});

export default router;
