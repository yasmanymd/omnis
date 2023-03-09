// ** MUI Imports
import { styled } from '@mui/material/styles'
import Box from '@mui/material/Box'

const BoardWrapper = styled(Box)(({ theme }) => {
  console.log(theme)
  return {
    '& .MuiPaper-root': {
      backgroundColor: theme.palette.background.paper
    }
  };
})

export default BoardWrapper
