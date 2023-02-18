import { withApiAuthRequired } from '@auth0/nextjs-auth0';
import fs from 'fs/promises';
import path from 'path';

export default withApiAuthRequired(async function documents(req, res) {
  const { method } = req;
  const { entity_id } = req.query;
  let files;

  switch (method) {
    case 'GET':
      try {
        files = await fs.readdir(path.join(process.cwd(), '/public/docs/' + entity_id + '/'));
      } catch (error) {
        files = [];
      }
      res.status(200).json(files);
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