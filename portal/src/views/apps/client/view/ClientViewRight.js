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
import AccountOutline from 'mdi-material-ui/AccountOutline'
import NoteMultiple from 'mdi-material-ui/NoteMultiple'
import FileDocument from 'mdi-material-ui/FileDocument'

// ** Demo Components Imports
import ClientViewContacts from 'src/views/apps/client/view/ClientViewContacts'
import ClientViewDocuments from './ClientViewDocuments'

// ** Styled Tab component
const Tab = styled(MuiTab)(({ theme }) => ({
  minHeight: 48,
  flexDirection: 'row',
  '& svg': {
    marginBottom: '0 !important',
    marginRight: theme.spacing(3)
  }
}))

const ClientViewRight = ({ client, documents }) => {
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
        <Tab value='documents' label='Documents' icon={<FileDocument />} />
      </TabList>
      <Box sx={{ mt: 6 }}>
        <TabPanel sx={{ p: 0 }} value='contacts'>
          <ClientViewContacts contacts={client.contacts} />
        </TabPanel>
        <TabPanel sx={{ p: 0 }} value='documents'>
          <ClientViewDocuments documents={documents} client_id={client._id} />
        </TabPanel>
      </Box>
    </TabContext>
  )
}

export default ClientViewRight
