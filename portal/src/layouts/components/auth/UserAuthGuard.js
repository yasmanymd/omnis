// ** React Imports
import { useEffect } from 'react'

// ** Next Imports
import { useRouter } from 'next/router'

// ** Hooks Import
import { signOut, useSession } from 'next-auth/react'

const AuthGuard = props => {
  const { children, fallback } = props
  const session = useSession()
  const router = useRouter()
  useEffect(
    () => {
      if (!router.isReady) {
        return
      }
      let redirect = session.status === 'unauthenticated';
      if (!redirect && session.status == 'authenticated') {
        const tokenExp = JSON.parse(window.atob(session.data.accessToken.split('.')[1])).exp * 1000;
        redirect = Date.now() > tokenExp;
      }
      if (redirect) {
        if (router.asPath !== '/') {
          signOut({ callbackUrl: router.asPath, redirect: false }).then(() => {
            router.replace({
              pathname: '/login',
              //query: { returnUrl: router.asPath }
            })
          });
        } else {
          signOut({ callbackUrl: '/', redirect: false }).then(() => {
            router.replace('/login')
          });
        }
      }
    },
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [router.route, session.status]
  )
  if (session.status !== 'authenticated') {
    return fallback
  }

  return <>{children}</>
}

export default AuthGuard
