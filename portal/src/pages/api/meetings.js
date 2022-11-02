import { getAccessToken, withApiAuthRequired } from '@auth0/nextjs-auth0';

export default withApiAuthRequired(async function meetings(req, res) {
  const { method } = req;
  const { accessToken } = await getAccessToken(req, res);
  const url = process.env.GATEWAY_API_URL;
  const baseUrl = url?.indexOf('http') === 0 ? url : `https://${url}`;
  let response, result;
  
  switch (method) {
    case 'POST':
      response = await fetch(baseUrl + '/meetings', {
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${accessToken}`
        },
        method: 'POST',
        body: JSON.stringify(req.body)
      });
      result = await response.json();
      res.status(200).json(result);
      break;
    case 'GET':
      response = await fetch(encodeURI(baseUrl + '/meetings'), {
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${accessToken}`
        },
        method: 'GET'
      });
      result = await response.json();
      res.status(200).json(result);
      break;
    case 'DELETE':
        response = await fetch(encodeURI(baseUrl + '/meetings/' + req.query.id), {
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${accessToken}`
          },
          method: 'DELETE'
        });
        result = await response.json();
        res.status(200).json(result);
        break;
    default:
      res.setHeader('Allow', ['GET', 'POST', 'DELETE']);
      res.status(405).json({
        status: 405, 
        message: 'Method not allowed'
      });
      break;
  }
});