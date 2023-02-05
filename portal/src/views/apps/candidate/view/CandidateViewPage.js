// ** React Imports
import { useState, useEffect } from 'react'

// ** Next Import
import Link from 'next/link'

// ** MUI Imports
import Grid from '@mui/material/Grid'
import Alert from '@mui/material/Alert'

// ** Third Party Components
import axios from 'axios'

// ** Store Imports
import { useDispatch, useSelector } from 'react-redux'

// ** Demo Components Imports
import CandidateViewLeft from 'src/views/apps/candidate/view/CandidateViewLeft'
import CandidateViewRight from 'src/views/apps/candidate/view/CandidateViewRight'

// ** Actions Imports
import { fetchCandidate } from 'src/store/apps/candidate'

const CandidateView = ({ id }) => {
  // ** State
  const dispatch = useDispatch()
  const [error, setError] = useState(false)
  const store = useSelector(state => state.candidate)
  useEffect(() => {
    dispatch(
      fetchCandidate(id)
    )
  }, [id])
  if (store.candidate) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12} md={5} lg={4}>
          <CandidateViewLeft data={store.candidate} />
        </Grid>
        <Grid item xs={12} md={7} lg={8}>
          <CandidateViewRight candidate={store.candidate} />
        </Grid>
      </Grid>
    )
  } else if (error) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12}>
          <Alert severity='error'>
            User with the id: {id} does not exist. Please check the list of users:{' '}
            <Link href='/apps/candidate/list'>User List</Link>
          </Alert>
        </Grid>
      </Grid>
    )
  } else {
    return null
  }
}

export default CandidateView
