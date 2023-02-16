import { getAccessToken, withApiAuthRequired } from '@auth0/nextjs-auth0';
import path from 'path';
import fs from 'fs/promises';

export default withApiAuthRequired(async function handler(req, res) {
  const { method } = req;
  const { slug } = req.query;

  switch (method) {
    case 'DELETE':
      try {
        await fs.rm(path.join(process.cwd(), '/public', '/docs', '/' + slug[0], '/' + slug[1]));
        res.status(200).json({ done: 'ok' });
      } catch (error) {
        res.status(404).json({ done: 'false' });
      }
      break;
    default:
      res.setHeader('Allow', ['DELETE']);
      res.status(405).json({
        status: 405,
        message: 'Method not allowed'
      });
      break;
  }
});