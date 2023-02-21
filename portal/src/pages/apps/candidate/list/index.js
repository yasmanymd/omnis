// ** React Imports
import { useState, useEffect, useCallback } from 'react'

// ** Next Import
import Link from 'next/link'

// ** MUI Imports
import Box from '@mui/material/Box'
import Card from '@mui/material/Card'
import Grid from '@mui/material/Grid'
import { DataGrid } from '@mui/x-data-grid'
import { styled } from '@mui/material/styles'
import Typography from '@mui/material/Typography'

// ** Store Imports
import { useDispatch, useSelector } from 'react-redux'

// ** Custom Components Imports
import CustomChip from 'src/@core/components/mui/chip'
import CustomAvatar from 'src/@core/components/mui/avatar'

// ** Utils Import
import { getInitials } from 'src/@core/utils/get-initials'

// ** Actions Imports
import { fetchCandidates } from 'src/store/apps/candidate'

// ** Custom Components Imports
import TableHeader from 'src/views/apps/candidate/list/TableHeader'
import AddUserDrawer from 'src/views/apps/candidate/list/AddUserDrawer'

// ** Styled component for the link for the avatar without image
const AvatarWithoutImageLink = styled(Link)(({ theme }) => ({
  textDecoration: 'none',
  marginRight: theme.spacing(3)
}))

// ** renders client column
const renderClient = row => {
  return (
    <AvatarWithoutImageLink href={`/apps/candidate/view/${row.id}`}>
      <CustomAvatar
        skin='light'
        color={'primary'}
        sx={{ mr: 3, width: 30, height: 30, fontSize: '.875rem' }}
      >
        {getInitials(row.name ? row.name : 'John Doe')}
      </CustomAvatar>
    </AvatarWithoutImageLink>
  )
}

const columns = [
  {
    flex: 0.2,
    minWidth: 230,
    field: 'name',
    headerName: 'Candidate',
    renderCell: ({ row }) => {
      const { id, name } = row

      return (
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          {renderClient(row)}
          <Box sx={{ display: 'flex', alignItems: 'flex-start', flexDirection: 'column' }}>
            <Link href={`/apps/candidate/view/${id}`} passHref>
              <Typography
                noWrap
                component='a'
                variant='body2'
                sx={{ fontWeight: 600, color: 'text.primary', textDecoration: 'none' }}
              >
                {name}
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
    field: 'title',
    headerName: 'Title',
    renderCell: ({ row }) => {
      return (
        <Typography noWrap variant='body2'>
          {row.title}
        </Typography>
      )
    }
  },
  {
    flex: 0.15,
    field: 'status',
    //minWidth: 150,
    headerName: 'Status',
    renderCell: ({ row }) => {
      return (<CustomChip
        size='small'
        skin='light'
        label={row.status}
        sx={{ '& .MuiChip-label': { textTransform: 'capitalize' }, '&:not(:last-of-type)': { mr: 3 } }}
      />)
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
  {
    flex: 0.15,
    field: 'linkedin',
    //minWidth: 150,
    headerName: 'LinkedIn',
    renderCell: ({ row }) => {
      return (
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          {row.linkedin && <Link href={row.linkedin} passHref>
            <a target="_blank">
              <Typography noWrap component='a' variant='caption' sx={{ textDecoration: 'none' }}>
                Go to LinkedIn
              </Typography>
            </a>
          </Link>}
        </Box>
      )
    }
  }
]

const CandidateList = () => {
  // ** State
  const [role, setRole] = useState('')
  const [plan, setPlan] = useState('')
  const [value, setValue] = useState('')
  const [status, setStatus] = useState('')
  const [pageSize, setPageSize] = useState(10)
  const [addUserOpen, setAddUserOpen] = useState(false)

  // ** Hooks
  const dispatch = useDispatch()
  const store = useSelector(state => state.candidate)
  useEffect(() => {
    dispatch(
      fetchCandidates()
    )
  }, [dispatch, null])

  const handleFilter = useCallback(val => {
    setValue(val)
  }, [])

  const toggleAddUserDrawer = () => setAddUserOpen(!addUserOpen)

  return (
    <Grid container spacing={6}>
      <Grid item xs={12}>
        <Card>
          <TableHeader value={value} handleFilter={handleFilter} toggle={toggleAddUserDrawer} />
          <DataGrid
            autoHeight
            rows={store.candidates.length ?
              store.candidates.map(candidate => {
                return {
                  id: candidate._id,
                  name: candidate.name,
                  title: candidate.title,
                  status: candidate.status,
                  tags: candidate.tags || [],
                  linkedin: candidate?.contacts?.linkedin || ''
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
              items: [{ columnField: 'name', operatorValue: 'contains', value: value }]
            }}
          />
        </Card>
      </Grid>

      <AddUserDrawer open={addUserOpen} toggle={toggleAddUserDrawer} />
    </Grid>
  )
}

export default CandidateList
