import { getServerSession } from "next-auth/next"
import { authOptions } from "./auth/[...nextauth]"
import { getToken } from "next-auth/jwt"

export default async function config(req, res) {
  const session = await getServerSession(req, res, authOptions)
  if (session) {
    const { method } = req;
    const { accessToken } = await getToken({ req })
    const url = process.env.GATEWAY_API_URL;
    const baseUrl = url?.indexOf('http') === 0 ? url : `https://${url}`;
    let response, result;

    switch (method) {
      case 'GET':
        res.status(200).json({
          signalingServerUrl: process.env.NEXT_PUBLIC_SIGNALING_SERVER_URL,
          keycloakUrl: process.env.NEXT_PUBLIC_KEYCLOAK_URL,
          omnisUrl: process.env.NEXT_PUBLIC_OMNIS_URL
        });
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