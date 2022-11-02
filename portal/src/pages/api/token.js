import { getAccessToken, withApiAuthRequired } from '@auth0/nextjs-auth0';

export default withApiAuthRequired(async function token(req, res) {
  const { method } = req;
  const { accessToken } = await getAccessToken(req, res);
  
  switch (method) {
    case 'GET':
      res.status(200).send(accessToken);
      break;
    default:
      res.setHeader('Allow', ['GET']);
      res.status(405).json({
        status: 405, 
        message: 'Method not allowed'
      });
      break;
  }
});