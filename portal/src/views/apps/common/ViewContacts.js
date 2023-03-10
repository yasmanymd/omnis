// ** React Imports
import { useEffect, useState, useCallback } from 'react'
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
import { Button, Dialog, DialogContent, DialogContentText, DialogTitle, DialogActions, IconButton, TableFooter, TextField, Box, Grid } from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import EditIcon from '@mui/icons-material/Edit'
import FormControl from '@mui/material/FormControl'
import FormHelperText from '@mui/material/FormHelperText';

// ** Third Parties
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm, Controller } from 'react-hook-form';

const ViewContacts = ({ contacts, addEditContacts, deleteContacts }) => {
  const [openEdit, setOpenEdit] = useState(false)
  const [contact, setContact] = useState(null);

  const handleAddEditContactClickOpen = () => setOpenEdit(true)
  const handleAddEditContactClickClose = () => {
    setContact(null)
    setOpenEdit(false)
  }

  const schema = yup.object().shape({
    key: yup.string().required('Key is a required field.'),
    value: yup.string().required('Value is a required field.')
  }).required();

  const {
    control,
    setValue,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: { key: '', value: '' }, resolver: yupResolver(schema) });

  const resetToStoredValues = useCallback(() => {
    if (!contact) {
      setValue('key', null);
      setValue('value', null);
    } else {
      setValue('key', contact.key.toLowerCase());
      setValue('value', contact.value);
    }
  }, [setValue, contact]);

  useEffect(() => {
    resetToStoredValues();
  }, [openEdit, contact]);

  const onSubmit = data => {
    data.key = data.key.toLowerCase();
    addEditContacts(data);
    setOpenEdit(false);
    setContact(null);
  }

  return (
    <Fragment>
      <Card sx={{ mb: 6 }}>
        <Box sx={{ p: 5, pb: 3, display: 'flex', flexWrap: 'wrap', alignItems: 'right', justifyContent: 'right' }}>
          <Box sx={{ display: 'flex', flexWrap: 'wrap', alignItems: 'center' }}>
            <Button variant='contained' sx={{ mb: 2 }} onClick={handleAddEditContactClickOpen}>
              Add Contact
            </Button>
          </Box>
        </Box>

        <TableContainer>
          <Table size='small' sx={{ minWidth: 500 }}>
            <TableHead
              sx={{ backgroundColor: theme => (theme.palette.mode === 'light' ? 'grey.50' : 'background.default') }}
            >
              <TableRow>
                <TableCell sx={{ height: '3.375rem' }}>Contacts</TableCell>
                <TableCell sx={{ height: '3.375rem' }}></TableCell>
                <TableCell sx={{ height: '3.375rem' }} align='right'>

                </TableCell>
              </TableRow>
            </TableHead>

            <TableBody>
              {Object.entries(contacts || {}).sort().map(([key, value], index) => (
                <TableRow hover key={index} sx={{ '&:last-of-type td': { border: 0 } }}>
                  <TableCell>
                    <Typography variant='body2' sx={{ textTransform: 'capitalize' }}>
                      {key}
                    </Typography>
                  </TableCell>
                  <TableCell>
                    {key != 'linkedin' ? value : (<Link target="_blank" href={value}>{value}</Link>)}
                  </TableCell>
                  <TableCell align='right'>
                    <IconButton aria-label="edit" onClick={() => {
                      setContact({ key, value })
                      handleAddEditContactClickOpen()
                    }}>
                      <EditIcon />
                    </IconButton>
                    <IconButton aria-label="delete" onClick={() => deleteContacts(key)}>
                      <DeleteIcon />
                    </IconButton>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
        <Dialog
          open={openEdit}
          onClose={handleAddEditContactClickClose}
          aria-labelledby='user-view-edit'
          sx={{ '& .MuiPaper-root': { width: '100%', maxWidth: 650, p: [2, 10] } }}
          aria-describedby='user-view-edit-description'
        >
          <form onSubmit={handleSubmit(onSubmit)} noValidate autoComplete='off'>
            <DialogTitle id='user-view-edit' sx={{ textAlign: 'center', fontSize: '1.5rem !important' }}>
              {contact ? 'Edit Contact Information' : 'Add Contact Information'}
            </DialogTitle>
            <DialogContent>
              <DialogContentText variant='body2' id='user-view-edit-description' sx={{ textAlign: 'center', mb: 7 }}>
              </DialogContentText>
              <Grid container spacing={2}>
                <Grid item xs={12} sm={12}>
                  <FormControl fullWidth sx={{ mb: 6 }}>
                    <Controller
                      name='key'
                      control={control}
                      rules={{ required: true }}
                      render={({ field: { value, onChange } }) => (
                        <TextField label='Key' disabled={contact} onChange={onChange} value={value} error={Boolean(errors.key)} />
                      )}
                    />
                    {errors.key && (
                      <FormHelperText sx={{ color: 'error.main' }} id='event-key-error'>
                        {errors.key.message}
                      </FormHelperText>
                    )}
                  </FormControl>
                </Grid>
                <Grid item xs={12} sm={12}>
                  <FormControl fullWidth sx={{ mb: 6 }}>
                    <Controller
                      name='value'
                      control={control}
                      rules={{ required: true }}
                      render={({ field: { value, onChange } }) => (
                        <TextField label='Value' value={value} onChange={onChange} error={Boolean(errors.value)} />
                      )}
                    />
                    {errors.value && (
                      <FormHelperText sx={{ color: 'error.main' }} id='event-value-error'>
                        {errors.value.message}
                      </FormHelperText>
                    )}
                  </FormControl>
                </Grid>
              </Grid>
            </DialogContent>
            <DialogActions sx={{ justifyContent: 'center' }}>
              <Button type='submit' variant='contained' sx={{ mr: 1 }}>
                Submit
              </Button>
              <Button variant='outlined' color='secondary' onClick={handleAddEditContactClickClose}>
                Cancel
              </Button>
            </DialogActions>
          </form>
        </Dialog>
      </Card>
    </Fragment >
  )
}

export default ViewContacts
