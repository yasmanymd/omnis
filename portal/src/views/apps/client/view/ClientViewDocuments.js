// ** React Imports
import { Card, List, ListItem, ListItemIcon, ListItemText, ListItemSecondaryAction, Link, Typography, Grid, Button } from '@mui/material';
import { FileDocumentOutline, Close, DeleteOutline } from 'mdi-material-ui';
import { Fragment, useEffect, useState } from 'react'
import { useDispatch } from 'react-redux'
import { fetchDocuments, deleteDocument } from 'src/store/apps/client';
import toast from 'react-hot-toast';
import ErrorDetails from '../../../../layouts/components/ErrorDetails';
import { IconAdd } from '@aws-amplify/ui-react';
import { PostAdd } from '@mui/icons-material';

const ClientViewDocuments = ({ documents, client_id }) => {
  const dispatch = useDispatch();
  const [selectedFile, setSelectedFile] = useState('');

  const handleDeleteDocument = async (doc) => {
    dispatch(deleteDocument({ client_id, doc }));
  }

  const handleUpload = async () => {
    try {
      const formData = new FormData();
      formData.append("myDoc", selectedFile);
      const response = await fetch('/api/docs/' + client_id, {
        method: 'POST',
        body: formData
      });
      dispatch(fetchDocuments(client_id));
      toast.success('Document uploaded.');
    } catch (error) {
      toast.error(<ErrorDetails message='Error uploading document.' errors={error} />);
    }
  }

  useEffect(() => {
    if (selectedFile) {
      handleUpload();
    }
  }, [selectedFile, setSelectedFile]);

  const documentsList = documents.map((doc) => (
    <ListItem>
      <ListItemIcon>
        <FileDocumentOutline fontSize='small' />
      </ListItemIcon>
      <ListItemText>
        <Link href={'/docs/' + client_id + '/' + doc} target="_blank" passHref>
          <Typography
            noWrap
            component='a'
            variant='body2'
            sx={{ fontWeight: 600, color: 'text.primary', textDecoration: 'none' }}
          >
            {doc}
          </Typography>
        </Link>
      </ListItemText>
      <ListItemSecondaryAction>
        <DeleteOutline
          fontSize='small'
          sx={{ cursor: 'pointer', mr: 2 }}
          onClick={() => handleDeleteDocument(doc)}
        />
      </ListItemSecondaryAction>
    </ListItem>
  ));

  return (
    <Fragment>
      <Card sx={{ mb: 6 }}>
        <List>
          {documentsList}
        </List>
        <label>
          <input
            type="file"
            hidden
            onChange={({ target }) => {
              if (target.files) {
                const file = target.files[0];
                setSelectedFile(file);
              }
            }}
          />
          <span>
            <Grid container sx={{ padding: 4 }}>
              <Grid item>
                <PostAdd />
              </Grid>

            </Grid>
          </span>
        </label>
      </Card>
    </Fragment>
  )
}

export default ClientViewDocuments
