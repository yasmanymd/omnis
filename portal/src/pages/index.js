// ** React Imports
import { useEffect } from 'react'

// ** Next Imports
import { useRouter } from 'next/router'

// ** Spinner Import
import Spinner from 'src/@core/components/spinner'

// ** Hook Imports
import { useUser } from '@auth0/nextjs-auth0';

const Home = () => {
  // ** Hooks
  const { user, error, isLoading } = useUser();

  if (isLoading) return <div>Loading...</div>;
  if (error) return <div>{error.message}</div>;
  
  const router = useRouter()

  useEffect(() => {
    if (!router.isReady) {
      return
    }

    if (user) {
      // Redirect user to Home URL
      router.replace('/home')
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return <Spinner />
}

export default Home
