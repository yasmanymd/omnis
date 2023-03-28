// ** MUI Imports
import { IconButton } from '@mui/material'
import Box from '@mui/material/Box'
import Button from '@mui/material/Button'
import TextField from '@mui/material/TextField'
import { LocationEnter } from 'mdi-material-ui'

// ** Icons Imports
import ExportVariant from 'mdi-material-ui/ExportVariant'

const TableHeader = props => {
  // ** Props
  const { handleFilter, toggle, value, assignToJob, selectionCandidates } = props

  return (
    <Box sx={{ p: 5, pb: 3, display: 'flex', flexWrap: 'wrap', alignItems: 'center', justifyContent: 'space-between' }}>
      <Box>
        <IconButton title='Assign to job' onClick={assignToJob} disabled={selectionCandidates.length === 0}>
          <LocationEnter />
        </IconButton>
      </Box>
      <Box sx={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center' }}>
        <TextField
          size='small'
          value={value}
          sx={{ mr: 4, mb: 2 }}
          placeholder='Search Candidate'
          onChange={e => handleFilter(e.target.value)}
        />

        <Button sx={{ mb: 2 }} onClick={toggle} variant='contained'>
          Add Candidate
        </Button>
      </Box>
    </Box>
  )
}

export default TableHeader
