class AppRouter {
   app = null;

   constructor(app) {
      this.app = app;
   }

   init() {
      this.app.get('/api', (req, res) => {
         res.json({ message: 'hello get request' });
      });
   }
}

export default AppRouter;
