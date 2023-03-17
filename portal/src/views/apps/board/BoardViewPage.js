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
import { fetchWorkflow } from 'src/store/apps/job'
import { Board } from '../../../layouts/components/kanban/Board/Board'

const BoardViewPage = ({ id }) => {
  // ** State
  const dispatch = useDispatch()
  const [error, setError] = useState(false)
  const store = useSelector(state => state.job)

  useEffect(() => {
    dispatch(fetchWorkflow(id))
  }, [id])

  if (store.workflow) {
    let workflow = store.workflow;
    let mapping = {};
    let initBoard = {
      initLanes: workflow.status.map((lane, index) => {
        mapping[lane.name] = index;
        return {
          id: index,
          name: lane.name,
          cards: []
        };
      }),
      formatDate: (date) => Intl.DateTimeFormat("en-US").format(date),
      height: '440px'
    };
    workflow.candidates?.map(candidate => {
      initBoard.initLanes[mapping[candidate.status]].cards.push({
        id: candidate.candidate_id,
        name: candidate.name,
        date: candidate.modified_date
      })
    });

    return (
      <Board {...initBoard} />
    )
  } else if (error) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12}>
          <Alert severity='error'>
            Board with the id: {id} does not exist. Please check the list of jobs:{' '}
            <Link href='/apps/job/list'>Job List</Link>
          </Alert>
        </Grid>
      </Grid>
    )
  } else {
    return null
  }
}

export default BoardViewPage
