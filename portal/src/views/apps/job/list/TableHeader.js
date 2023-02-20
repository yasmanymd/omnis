// ** MUI Imports
import Box from '@mui/material/Box'
import Button from '@mui/material/Button'

const TableHeader = props => {
  // ** Props
  const { toggle } = props

  return (
    <Box sx={{ p: 5, pb: 3, display: 'flex', flexWrap: 'wrap', alignItems: 'right', justifyContent: 'right' }}>
      <Box sx={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center' }}>
        <Button sx={{ mb: 2 }} onClick={toggle} variant='contained'>
          Add Job
        </Button>
      </Box>
    </Box>
  )
}

export default TableHeader
