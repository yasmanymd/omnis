// ** React Imports
import { useEffect, useState, useCallback } from 'react'

// ** MUI Imports
import Box from '@mui/material/Box'
import Grid from '@mui/material/Grid'
import Card from '@mui/material/Card'
import Button from '@mui/material/Button'
import Dialog from '@mui/material/Dialog'
import Select from '@mui/material/Select'
import OutlinedInput from '@mui/material/OutlinedInput'
import Divider from '@mui/material/Divider'
import MenuItem from '@mui/material/MenuItem'
import { styled } from '@mui/material/styles'
import TextField from '@mui/material/TextField'
import Typography from '@mui/material/Typography'
import InputLabel from '@mui/material/InputLabel'
import CardContent from '@mui/material/CardContent'
import CardActions from '@mui/material/CardActions'
import DialogTitle from '@mui/material/DialogTitle'
import FormControl from '@mui/material/FormControl'
import FormHelperText from '@mui/material/FormHelperText';
import DialogContent from '@mui/material/DialogContent'
import DialogActions from '@mui/material/DialogActions'
import DialogContentText from '@mui/material/DialogContentText'

// ** Custom Components
import CustomChip from 'src/@core/components/mui/chip'
import CustomAvatar from 'src/@core/components/mui/avatar'

// ** Utils Import
import { getInitials } from 'src/@core/utils/get-initials'

// ** Third Parties
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm, Controller } from 'react-hook-form';

// ** Store Imports
import { useDispatch } from 'react-redux'

// ** Actions Imports
import { updateClient } from 'src/store/apps/client'
import { Autocomplete, Chip } from '@mui/material'

const statusColors = {
  active: 'success',
  pending: 'warning',
  none: 'secondary'
}

const ClientViewLeft = props => {
  const { client } = props;
  const dispatch = useDispatch()

  const schema = yup.object().shape({
    name: yup.string().required('Name is a required field.'),
    description: yup.string().required('Description is a required field.')
  }).required();

  const {
    control,
    setValue,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: { ...client }, resolver: yupResolver(schema) });

  const resetToStoredValues = useCallback(() => {
    if (client) {
      setValue('name', client.name);
      setValue('description', client.description);
    }
  }, [setValue, client]);

  const onSubmit = data => {
    const modifiedClient = {
      _id: client._id,
      name: data.name,
      description: data.description
    };

    dispatch(updateClient(modifiedClient));
    setOpenEdit(false);
  }

  // ** States
  const [openEdit, setOpenEdit] = useState(false)

  useEffect(() => {
    resetToStoredValues();
  }, [openEdit, client]);

  // Handle Edit dialog
  const handleEditClickOpen = () => setOpenEdit(true)
  const handleEditClose = () => setOpenEdit(false)

  // Handle Upgrade Plan dialog

  const renderUserAvatar = () => {
    if (client) {
      return (
        <CustomAvatar
          skin='light'
          variant='rounded'
          color='primary'
          sx={{ width: 120, height: 120, fontWeight: 600, mb: 4, fontSize: '3rem' }}
        >
          {getInitials(client.name)}
        </CustomAvatar>
      )
    } else {
      return null
    }
  }
  if (client) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12}>
          <Card>
            <CardContent sx={{ pt: 15, display: 'flex', alignItems: 'center', flexDirection: 'column' }}>
              {renderUserAvatar()}
              <Typography variant='h6' sx={{ mb: 2 }}>
                {client.name}
              </Typography>
            </CardContent>
            <CardContent>
              <Typography variant='h6'>Details</Typography>
              <Divider />
              <Box sx={{ pt: 2, pb: 2 }}>
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Name:</Typography>
                  <Typography variant='body2'>{client.name}</Typography>
                </Box>
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Role:</Typography>
                  <Typography variant='body2' sx={{ textTransform: 'capitalize' }}>
                    Client
                  </Typography>
                </Box>
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Description:</Typography>
                  <Typography variant='body2' style={{ 'white-space': 'pre-wrap' }}>{client.description}</Typography>
                </Box>
              </Box>
            </CardContent>

            <CardActions sx={{ display: 'flex', justifyContent: 'center' }}>
              <Button variant='contained' sx={{ mr: 3 }} onClick={handleEditClickOpen}>
                Edit
              </Button>
            </CardActions>

            <Dialog
              open={openEdit}
              onClose={handleEditClose}
              aria-labelledby='user-view-edit'
              sx={{ '& .MuiPaper-root': { width: '100%', maxWidth: 650, p: [2, 10] } }}
              aria-describedby='user-view-edit-description'
            >
              <form onSubmit={handleSubmit(onSubmit)} noValidate autoComplete='off'>
                <DialogTitle id='user-view-edit' sx={{ textAlign: 'center', fontSize: '1.5rem !important' }}>
                  Edit Client Information
                </DialogTitle>
                <DialogContent>
                  <DialogContentText variant='body2' id='user-view-edit-description' sx={{ textAlign: 'center', mb: 7 }}>
                  </DialogContentText>
                  <Grid container spacing={2}>
                    <Grid item xs={12} sm={12}>
                      <FormControl fullWidth sx={{ mb: 6 }}>
                        <Controller
                          name='name'
                          control={control}
                          rules={{ required: true }}
                          render={({ field: { value, onChange } }) => (
                            <TextField label='Name' value={value} onChange={onChange} error={Boolean(errors.name)} />
                          )}
                        />
                        {errors.name && (
                          <FormHelperText sx={{ color: 'error.main' }} id='event-name-error'>
                            {errors.name.message}
                          </FormHelperText>
                        )}
                      </FormControl>
                    </Grid>
                    <Grid item xs={12} sm={12}>
                      <FormControl fullWidth sx={{ mb: 6 }}>
                        <Controller
                          name='description'
                          control={control}
                          rules={{ required: true }}
                          render={({ field: { value, onChange } }) => (
                            <TextField multiline minRows={4} maxRows={4} label='Description' value={value} onChange={onChange} error={Boolean(errors.description)} />
                          )}
                        />
                        {errors.description && (
                          <FormHelperText sx={{ color: 'error.main' }} id='event-description-error'>
                            {errors.description.message}
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
                  <Button variant='outlined' color='secondary' onClick={handleEditClose}>
                    Cancel
                  </Button>
                </DialogActions>
              </form>
            </Dialog>
          </Card>
        </Grid>
      </Grid>
    )
  } else {
    return null
  }
}

export default ClientViewLeft
