// ** React Imports
import { useState } from 'react'

// ** Store Imports
import { useDispatch } from 'react-redux'

// ** MUI Imports
import Box from '@mui/material/Box'
import TabList from '@mui/lab/TabList'
import TabPanel from '@mui/lab/TabPanel'
import TabContext from '@mui/lab/TabContext'
import { styled } from '@mui/material/styles'
import MuiTab from '@mui/material/Tab'

// ** Icons Imports
import AccountOutline from 'mdi-material-ui/AccountOutline'
import FileDocument from 'mdi-material-ui/FileDocument'

// ** Demo Components Imports
import ViewContacts from '../../common/ViewContacts'
import ViewDocuments from '../../common/ViewDocuments'

import { fetchDocuments, deleteDocument } from '../../../../store/apps/client'

// ** Styled Tab component
const Tab = styled(MuiTab)(({ theme }) => ({
  minHeight: 48,
  flexDirection: 'row',
  '& svg': {
    marginBottom: '0 !important',
    marginRight: theme.spacing(3)
  }
}))

const ClientViewRight = ({ client, documents, updateClient }) => {
  const dispatch = useDispatch();

  // ** State
  const [value, setValue] = useState('contacts')

  const handleChange = (event, newValue) => {
    setValue(newValue)
  }

  const addContacts = ({ key, value }) => {
    let modifiedClient = {
      ...client,
      contacts: { ...client.contacts }
    };
    modifiedClient.contacts[key] = value;
    dispatch(updateClient(modifiedClient))
  }

  const deleteContacts = (key) => {
    let modifiedClient = { ...client, contacts: { ...client.contacts } }
    delete modifiedClient.contacts[key];
    dispatch(updateClient(modifiedClient))
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
          <ViewContacts
            contacts={client.contacts}
            addContacts={addContacts}
            deleteContacts={deleteContacts} />
        </TabPanel>
        <TabPanel sx={{ p: 0 }} value='documents'>
          <ViewDocuments
            documents={documents}
            entity_id={client._id}
            fetchDocuments={fetchDocuments}
            deleteDocument={deleteDocument} />
        </TabPanel>
      </Box>
    </TabContext>
  )
}

export default ClientViewRight
