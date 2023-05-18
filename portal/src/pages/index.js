// ** React Imports
import { useEffect } from 'react'

// ** Next Imports
import { useRouter } from 'next/router'

// ** Spinner Import
import Spinner from 'src/@core/components/spinner'

// ** Hook Imports
import { useSession } from 'next-auth/react'

const Home = () => {
  // ** Hooks
  const session = useSession()
  const router = useRouter()
  useEffect(() => {
    if (session.status === 'authenticated') {
      // Redirect user to Home URL
      router.replace('/home')
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return <Spinner />
}

export default Home
