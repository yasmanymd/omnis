// ** React Imports
import { useState, useEffect } from 'react'

// ** Next Import
import Link from 'next/link'

// ** MUI Imports
import Grid from '@mui/material/Grid'
import Alert from '@mui/material/Alert'

// ** Store Imports
import { useDispatch, useSelector } from 'react-redux'

// ** Actions Imports
import { fetchClient } from 'src/store/apps/client'


// ** Demo Components Imports
import ClientViewLeft from 'src/views/apps/client/view/ClientViewLeft'
import ClientViewRight from 'src/views/apps/client/view/ClientViewRight'

const ClientViewPage = ({ id }) => {
  // ** State
  const dispatch = useDispatch()
  const [error, setError] = useState(false)
  const store = useSelector(state => state.client)
  useEffect(() => {
    dispatch(
      fetchClient(id)
    )
  }, [id])
  if (store.client) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12} md={5} lg={4}>
          <ClientViewLeft client={store.client} />
        </Grid>
        <Grid item xs={12} md={7} lg={8}>
          <ClientViewRight client={store.client} documents={store.documents} />
        </Grid>
      </Grid>
    )
  } else if (error) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12}>
          <Alert severity='error'>
            Client with the id: {id} does not exist. Please check the list of clients:{' '}
            <Link href='/apps/client/list'>Client List</Link>
          </Alert>
        </Grid>
      </Grid>
    )
  } else {
    return null
  }
}

export default ClientViewPage
