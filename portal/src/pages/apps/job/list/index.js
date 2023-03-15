// ** React Imports
import { useState, useEffect, useCallback } from 'react'

// ** Next Import
import Link from 'next/link'

// ** MUI Imports
import Box from '@mui/material/Box'
import Card from '@mui/material/Card'
import Grid from '@mui/material/Grid'
import CustomChip from 'src/@core/components/mui/chip'
import { DataGrid } from '@mui/x-data-grid'
import Typography from '@mui/material/Typography'

// ** Store Imports
import { useDispatch, useSelector } from 'react-redux'

// ** Actions Imports
import { fetchJobs } from 'src/store/apps/job'

// ** Custom Components Imports
import TableHeader from 'src/views/apps/job/list/TableHeader'
import AddJobDrawer from 'src/views/apps/job/list/AddJobDrawer'

const columns = [
  {
    flex: 0.2,
    minWidth: 230,
    field: 'title',
    headerName: 'Title',
    renderCell: ({ row }) => {
      const { id, title } = row

      return (
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          <Box sx={{ display: 'flex', alignItems: 'flex-start', flexDirection: 'column' }}>
            <Link href={`/apps/job/view/${id}`} passHref>
              <Typography
                noWrap
                component='a'
                variant='body2'
                sx={{ fontWeight: 600, color: 'text.primary', textDecoration: 'none' }}
              >
                {title}
              </Typography>
            </Link>
          </Box>
        </Box>
      )
    }
  },
  {
    flex: 0.2,
    minWidth: 250,
    field: 'description',
    headerName: 'Description',
    renderCell: ({ row }) => {
      return (
        <Typography noWrap variant='body2'>
          {row.description}
        </Typography>
      )
    }
  },
  {
    flex: 0.15,
    field: 'tags',
    //minWidth: 150,
    headerName: 'Tags',
    renderCell: ({ row }) => {
      return row.tags.map((tag, index) => (
        <CustomChip
          size='small'
          key={index}
          skin='light'
          label={tag}
          sx={{ '& .MuiChip-label': { textTransform: 'capitalize' }, '&:not(:last-of-type)': { mr: 3 } }}
        />
      ))
    }
  },
]

const JobList = () => {
  // ** State
  const [value, setValue] = useState('')
  const [pageSize, setPageSize] = useState(10)
  const [addJobOpen, setAddJobOpen] = useState(false)

  // ** Hooks
  const dispatch = useDispatch()
  const store = useSelector(state => state.job)
  useEffect(() => {
    dispatch(fetchJobs());
  }, [dispatch, null])

  const handleFilter = useCallback(val => {
    setValue(val)
  }, [])

  const toggleAddJobDrawer = () => setAddJobOpen(!addJobOpen)

  return (
    <Grid container spacing={6}>
      <Grid item xs={12}>
        <Card>
          <TableHeader value={value} handleFilter={handleFilter} toggle={toggleAddJobDrawer} />
          <DataGrid
            autoHeight
            rows={store.jobs.length ?
              store.jobs.map(job => {
                return {
                  id: job._id,
                  title: job.title,
                  description: job.description,
                  tags: job.tags
                }
              }
              ) : []}
            columns={columns}
            checkboxSelection
            pageSize={pageSize}
            disableSelectionOnClick
            rowsPerPageOptions={[10, 25, 50]}
            onPageSizeChange={newPageSize => setPageSize(newPageSize)}
            filterModel={{
              items: [{ columnField: 'title', operatorValue: 'contains', value: value }]
            }}
          />
        </Card>
      </Grid>

      <AddJobDrawer open={addJobOpen} toggle={toggleAddJobDrawer} clients={store.clients} workflowTemplates={store.workflowTemplates} />
    </Grid>
  )
}

export default JobList
