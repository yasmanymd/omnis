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
import { fetchJob, updateJob } from 'src/store/apps/job'


// ** Demo Components Imports
import JobViewLeft from 'src/views/apps/job/view/JobViewLeft'
import JobViewRight from 'src/views/apps/job/view/JobViewRight'

const JobViewPage = ({ id }) => {
  // ** State
  const dispatch = useDispatch()
  const [error, setError] = useState(false)
  const store = useSelector(state => state.job)
  useEffect(() => {
    dispatch(
      fetchJob(id)
    )
  }, [id])
  if (store.job) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12} md={5} lg={4}>
          <JobViewLeft job={store.job} updateJob={updateJob} />
        </Grid>
        <Grid item xs={12} md={7} lg={8}>
          <JobViewRight job={store.job} documents={store.documents} updateJob={updateJob} />
        </Grid>
      </Grid>
    )
  } else if (error) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12}>
          <Alert severity='error'>
            Job with the id: {id} does not exist. Please check the list of jobs:{' '}
            <Link href='/apps/job/list'>Job List</Link>
          </Alert>
        </Grid>
      </Grid>
    )
  } else {
    return null
  }
}

export default JobViewPage
