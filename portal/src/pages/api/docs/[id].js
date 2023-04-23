import { getAccessToken, withApiAuthRequired } from '@auth0/nextjs-auth0';
import formidable from 'formidable';
import path from 'path';
import fs from 'fs/promises';

export const config = {
  api: {
    bodyParser: false
  }
};

const readFile = (req, saveLocally, entity_id) => {
  const options = {};
  if (saveLocally) {
    options.uploadDir = path.join(process.cwd(), '/public/docs/' + entity_id);
    options.filename = (name, ext, path) => {
      return path.originalFilename;
    }
  }
  const form = formidable(options);

  return new Promise((resolve, reject) => {
    form.parse(req, (err, fields, files) => {
      if (err) {
        reject(err);
      }
      resolve({ fields, files });
    });
  });
}

export default withApiAuthRequired(async function docs(req, res) {
  const { method } = req;

  switch (method) {
    case 'POST':
      try {
        await fs.readdir(path.join(process.cwd(), '/public', '/docs', '/' + req.query.id));
      } catch (error) {
        await fs.mkdir(path.join(process.cwd(), '/public', '/docs', '/' + req.query.id), { recursive: true });
      }
      try {
        await readFile(req, true, req.query.id);
        res.status(200).json({ done: 'ok' });
      } catch (error) {
        res.status(500).json({ done: 'false' });
      }
      break;
    default:
      res.setHeader('Allow', ['POST']);
      res.status(405).json({
        status: 405,
        message: 'Method not allowed'
      });
      break;
  }
});