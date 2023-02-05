// ** React Imports
import { useState } from 'react'

// ** MUI Imports
import Box from '@mui/material/Box'
import TabList from '@mui/lab/TabList'
import TabPanel from '@mui/lab/TabPanel'
import TabContext from '@mui/lab/TabContext'
import { styled } from '@mui/material/styles'
import MuiTab from '@mui/material/Tab'

// ** Icons Imports
import LockOutline from 'mdi-material-ui/LockOutline'
import BellOutline from 'mdi-material-ui/BellOutline'
import LinkVariant from 'mdi-material-ui/LinkVariant'
import AccountOutline from 'mdi-material-ui/AccountOutline'
import BookmarkOutline from 'mdi-material-ui/BookmarkOutline'

// ** Demo Components Imports
import UserViewBilling from 'src/views/apps/candidate/view/UserViewBilling'
import CandidateViewContacts from 'src/views/apps/candidate/view/CandidateViewContacts'
import UserViewSecurity from 'src/views/apps/candidate/view/UserViewSecurity'
import UserViewConnection from 'src/views/apps/candidate/view/UserViewConnection'
import UserViewNotification from 'src/views/apps/candidate/view/UserViewNotification'

// ** Styled Tab component
const Tab = styled(MuiTab)(({ theme }) => ({
  minHeight: 48,
  flexDirection: 'row',
  '& svg': {
    marginBottom: '0 !important',
    marginRight: theme.spacing(3)
  }
}))

const CandidateViewRight = ({ candidate }) => {
  // ** State
  const [value, setValue] = useState('contacts')

  const handleChange = (event, newValue) => {
    setValue(newValue)
  }

  return (
    <TabContext value={value}>
      <TabList
        variant='scrollable'
        scrollButtons='auto'
        onChange={handleChange}
        aria-label='forced scroll tabs example'
        sx={{ borderBottom: theme => `1px solid ${theme.palette.divider}` }}
      >
        <Tab value='contacts' label='Contacts' icon={<AccountOutline />} />
      </TabList>
      <Box sx={{ mt: 6 }}>
        <TabPanel sx={{ p: 0 }} value='contacts'>
          <CandidateViewContacts contacts={candidate.contacts} />
        </TabPanel>
      </Box>
    </TabContext>
  )
}

export default CandidateViewRight
