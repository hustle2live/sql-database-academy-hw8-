// api_key = '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'



class AppRouter {
   app = null;

   constructor(app) {
      this.app = app;
   }

   init() {
      this.app.get('/api', async (req, res) => {
         res.json({ message: 'hello get request' });
      });

      this.app.post('/api', async (req, res) => {
         try {
            const { message, token } = req.query;
            console.log('message: ' + message);
            console.log('token: ' + token);

            const response = await fetch('https://api.anthropic.com/v1/messages', {
               method: 'POST',
               headers: {
                  'x-api-key': token,
                  'anthropic-version': '2023-06-01',
                  'content-type': 'application/json'
               },
               body: JSON.stringify({
                  model: 'claude-3-7-sonnet-20250219',
                  max_tokens: 300,
                  messages: [
                     {
                        role: 'user',
                        content: message
                     }
                  ]
               })
            });

            if (!response.ok) {
               const errorData = await response.text();

               console.log('Error response:', errorData);

               throw new Error(
                  `Error occurred during POST request: ${response.status} ${response.statusText} ${errorData}`
               );
            }

            const responseData = await response.json();

            return res.status(200).json({ data: responseData });
         } catch (error) {
            console.log(error);
            return res.status(400).json({ data: error?.message ?? error });
         }
      });
   }
}



export default AppRouter;


