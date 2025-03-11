import express from 'express';
import AppRouter from './appRouter.js';
import bodyParser from 'body-parser';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

const router = new AppRouter(app);

router.init();

app.get('/', (_, res) => {
    res.send('Hello world');
});

app.listen(PORT, () => {
   console.log('Server is running on port http://localhost:' + PORT);
});



