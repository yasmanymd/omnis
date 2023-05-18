import { getServerSession } from "next-auth/next"
import { authOptions } from "./auth/[...nextauth]"
import { getToken } from "next-auth/jwt"

export default async function token(req, res) {
  const session = await getServerSession(req, res, authOptions)
  if (session) {
    const { method } = req;
    const { accessToken } = await getToken({ req });

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
  } else {
    // Not Signed in
    res.status(401)
  }
  res.end()
};