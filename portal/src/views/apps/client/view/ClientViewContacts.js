// ** React Imports
import { Fragment } from 'react'

// ** MUI Imports
import Card from '@mui/material/Card'
import Table from '@mui/material/Table'
import TableRow from '@mui/material/TableRow'
import TableHead from '@mui/material/TableHead'
import TableBody from '@mui/material/TableBody'
import TableCell from '@mui/material/TableCell'
import Typography from '@mui/material/Typography'
import TableContainer from '@mui/material/TableContainer'
import Link from '@mui/material/Link'

const CandidateViewContacts = ({ contacts }) => {
  return (
    <Fragment>
      <Card sx={{ mb: 6 }}>
        <TableContainer>
          <Table size='small' sx={{ minWidth: 500 }}>
            <TableHead
              sx={{ backgroundColor: theme => (theme.palette.mode === 'light' ? 'grey.50' : 'background.default') }}
            >
              <TableRow>
                <TableCell sx={{ height: '3.375rem' }}>Contacts</TableCell>
                <TableCell sx={{ height: '3.375rem' }}></TableCell>
              </TableRow>
            </TableHead>

            <TableBody>
              {Object.entries(contacts).map(([key, value], index) => (
                <TableRow hover key={index} sx={{ '&:last-of-type td': { border: 0 } }}>
                  <TableCell>
                    <Typography variant='body2' sx={{ textTransform: 'capitalize' }}>
                      {key}
                    </Typography>
                  </TableCell>
                  <TableCell>
                    {key != 'linkedin' ? value : (<Link target="_blank" href={value}>{value}</Link>)}
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Card>
    </Fragment>
  )
}

export default CandidateViewContacts
