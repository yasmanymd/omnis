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
import NoteMultiple from 'mdi-material-ui/NoteMultiple'
import FileDocument from 'mdi-material-ui/FileDocument'

// ** Demo Components Imports
import ViewContacts from '../../common/ViewContacts'
import CandidateViewNotes from './CandidateViewNotes'
import ViewDocuments from '../../common/ViewDocuments'

import { fetchDocuments, deleteDocument } from '../../../../store/apps/candidate'

// ** Styled Tab component
const Tab = styled(MuiTab)(({ theme }) => ({
  minHeight: 48,
  flexDirection: 'row',
  '& svg': {
    marginBottom: '0 !important',
    marginRight: theme.spacing(3)
  }
}))

const CandidateViewRight = ({ candidate, notes, documents, updateCandidate }) => {
  const dispatch = useDispatch()

  // ** State
  const [value, setValue] = useState('contacts')

  const handleChange = (event, newValue) => {
    setValue(newValue)
  }

  const addEditContacts = ({ key, value }) => {
    let modifiedCandidate = {
      ...candidate,
      contacts: { ...candidate.contacts }
    };
    modifiedCandidate.contacts[key] = value;
    dispatch(updateCandidate(modifiedCandidate))
  }

  const deleteContacts = (key) => {
    let modifiedCandidate = {
      ...candidate,
      contacts: { ...candidate.contacts }
    }
    delete modifiedCandidate.contacts[key];
    dispatch(updateCandidate(modifiedCandidate))
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
        <Tab value='notes' label='Notes' icon={<NoteMultiple />} />
        <Tab value='documents' label='Documents' icon={<FileDocument />} />
      </TabList>
      <Box sx={{ mt: 6 }}>
        <TabPanel sx={{ p: 0 }} value='contacts'>
          <ViewContacts
            contacts={candidate.contacts}
            addEditContacts={addEditContacts}
            deleteContacts={deleteContacts} />
        </TabPanel>
        <TabPanel sx={{ p: 0 }} value='notes'>
          <CandidateViewNotes notes={notes} candidate_id={candidate._id} />
        </TabPanel>
        <TabPanel sx={{ p: 0 }} value='documents'>
          <ViewDocuments
            documents={documents}
            entity_id={candidate._id}
            fetchDocuments={fetchDocuments}
            deleteDocument={deleteDocument} />
        </TabPanel>
      </Box>
    </TabContext>
  )
}

export default CandidateViewRight
