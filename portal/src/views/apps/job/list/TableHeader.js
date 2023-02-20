// ** MUI Imports
import { TextField } from '@mui/material'
import Box from '@mui/material/Box'
import Button from '@mui/material/Button'

const TableHeader = props => {
  // ** Props
  const { handleFilter, toggle, value } = props

  return (
    <Box sx={{ p: 5, pb: 3, display: 'flex', flexWrap: 'wrap', alignItems: 'right', justifyContent: 'right' }}>
      <Box sx={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center' }}>
        <TextField
          size='small'
          value={value}
          sx={{ mr: 4, mb: 2 }}
          placeholder='Search Job'
          onChange={e => handleFilter(e.target.value)}
        />
        <Button sx={{ mb: 2 }} onClick={toggle} variant='contained'>
          Add Job
        </Button>
      </Box>
    </Box>
  )
}

export default TableHeader
