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
import { updateCandidate } from 'src/store/apps/candidate'
import { Autocomplete, Chip } from '@mui/material'

const statusColors = {
  active: 'success',
  pending: 'warning',
  none: 'secondary'
}

const CandidateViewLeft = props => {
  const { candidate } = props;
  const dispatch = useDispatch()

  const schema = yup.object().shape({
    name: yup.string().required('Name is a required field.'),
    title: yup.string().required('Title is a required field.'),
    status: yup.string().required('Status is a required field.')
  }).required();

  const {
    control,
    setValue,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: { ...candidate }, resolver: yupResolver(schema) });

  const resetToStoredValues = useCallback(() => {
    if (candidate) {
      setValue('name', candidate.name);
      setValue('title', candidate.title);
      setValue('tags', candidate.tags || []);
      setValue('status', candidate.status);
    }
  }, [setValue, candidate]);

  const onSubmit = data => {
    const modifiedCandidate = {
      ...candidate,
      name: data.name,
      title: data.title,
      tags: data.tags,
      status: data.status
    };

    dispatch(updateCandidate(modifiedCandidate));
    setOpenEdit(false);
  }

  // ** States
  const [openEdit, setOpenEdit] = useState(false)

  useEffect(() => {
    resetToStoredValues();
  }, [openEdit, candidate]);

  // Handle Edit dialog
  const handleEditClickOpen = () => setOpenEdit(true)
  const handleEditClose = () => setOpenEdit(false)

  // Handle Upgrade Plan dialog

  const renderUserAvatar = () => {
    if (candidate) {
      return (
        <CustomAvatar
          skin='light'
          variant='rounded'
          color='primary'
          sx={{ width: 120, height: 120, fontWeight: 600, mb: 4, fontSize: '3rem' }}
        >
          {getInitials(candidate.name)}
        </CustomAvatar>
      )
    } else {
      return null
    }
  }
  if (candidate) {
    return (
      <Grid container spacing={6}>
        <Grid item xs={12}>
          <Card>
            <CardContent sx={{ pt: 15, display: 'flex', alignItems: 'center', flexDirection: 'column' }}>
              {renderUserAvatar()}
              <Typography variant='h6' sx={{ mb: 2 }}>
                {candidate.name}
              </Typography>
              <CustomChip
                skin='light'
                size='small'
                label={candidate.title}
                color='primary'
                sx={{
                  height: 20,
                  fontSize: '0.875rem',
                  fontWeight: 600,
                  borderRadius: '5px',
                  textTransform: 'capitalize',
                  '& .MuiChip-label': { mt: -0.25 }
                }}
              />
            </CardContent>
            <CardContent>
              <Typography variant='h6'>Details</Typography>
              <Divider />
              <Box sx={{ pt: 2, pb: 2 }}>
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Name:</Typography>
                  <Typography variant='body2'>{candidate.name}</Typography>
                </Box>
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Role:</Typography>
                  <Typography variant='body2' sx={{ textTransform: 'capitalize' }}>
                    Candidate
                  </Typography>
                </Box>
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Status:</Typography>
                  <CustomChip
                    skin='light'
                    size='small'
                    label={candidate.status}
                    color={statusColors[candidate.status]}
                    sx={{
                      height: 20,
                      fontSize: '0.75rem',
                      fontWeight: 500,
                      borderRadius: '5px',
                      textTransform: 'capitalize'
                    }}
                  />
                </Box>
                {candidate.tags.length > 0 && (
                  <Box sx={{ display: 'flex', mb: 2.7 }}>
                    <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Tags:</Typography>
                    <Typography variant='body2'>
                      {candidate.tags.map(tag => (
                        <CustomChip
                          skin='light'
                          size='small'
                          label={tag}
                          sx={{
                            height: 20,
                            fontSize: '0.75rem',
                            fontWeight: 500,
                            borderRadius: '5px',
                            marginLeft: '5px'
                          }}
                        />
                      ))}
                    </Typography>
                  </Box>
                )}
                <Box sx={{ display: 'flex', mb: 2.7 }}>
                  <Typography sx={{ mr: 2, fontWeight: 500, fontSize: '0.875rem' }}>Created by:</Typography>
                  <Typography variant='body2'>
                    {candidate.created_by}
                  </Typography>
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
                  Edit Candidate Information
                </DialogTitle>
                <DialogContent>
                  <DialogContentText variant='body2' id='user-view-edit-description' sx={{ textAlign: 'center', mb: 7 }}>
                  </DialogContentText>
                  <Grid container spacing={6}>
                    <Grid item xs={12} sm={6}>
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
                    <Grid item xs={12} sm={6}>
                      <FormControl fullWidth sx={{ mb: 6 }}>
                        <Controller
                          name='title'
                          control={control}
                          rules={{ required: true }}
                          render={({ field: { value, onChange } }) => (
                            <TextField label='Title' value={value} onChange={onChange} error={Boolean(errors.title)} />
                          )}
                        />
                        {errors.title && (
                          <FormHelperText sx={{ color: 'error.main' }} id='event-title-error'>
                            {errors.title.message}
                          </FormHelperText>
                        )}
                      </FormControl>
                    </Grid>
                    <Grid item xs={12}>
                      <FormControl fullWidth sx={{ mb: 6 }}>
                        <Controller
                          name='tags'
                          control={control}
                          rules={{ required: false }}
                          render={({ field: { ref, ...field }, fieldState: { error } }) => (
                            <Autocomplete
                              {...field}
                              multiple
                              id="tags-filled"
                              options={['Java', '.Net', 'Python', 'Golang', 'PHP', 'VB.Net', 'Ruby on Rails', 'C++', 'Security', 'Network', 'Embedded Systems', 'Solidity', 'AEM', 'Elixir', 'Node', 'React Native', 'AWS', 'Azure', 'GCP', 'DevOps', 'SRE', 'QA Automation', 'QA Manual', 'Business Analyst', 'Functional Analyst', 'SysAdmin', 'Angular', 'React.js', 'Vue.js', 'Scrum Master', 'Project Manager', 'Consultant', 'Data Engineer', 'BI Architect', 'Cryptographer', 'Comunity Manager', 'Technical Support', 'iOS', 'Android', 'Flutter', 'CiberSecurity Analyst', 'BI Developer', 'BI Analyst', 'Architect', 'HL2023']}
                              freeSolo
                              onChange={(event, value) => field.onChange(value)}
                              renderTags={(v, getTagProps) =>
                                v.map((option, index) => (
                                  <Chip variant="outlined" label={option} color={Boolean(errors.tags) ? "error" : "default"} {...getTagProps({ index })} />
                                ))
                              }
                              renderInput={(params) => (
                                <TextField
                                  {...params}
                                  variant="outlined"
                                  label="Tags"
                                  inputRef={ref}
                                  error={Boolean(errors.tags)}
                                />
                              )}
                            />
                          )}
                        />
                      </FormControl>
                    </Grid>
                    <Grid item xs={12} sm={6}>
                      <FormControl>
                        <InputLabel id="status-label">Status</InputLabel>
                        <Controller
                          name="status"
                          control={control}
                          render={({ field }) => (
                            <Select labelId="status-label" input={<OutlinedInput label="Status" />} {...field}>
                              <MenuItem value='None'>None</MenuItem>
                              <MenuItem value='Connection Request'>Connection Request</MenuItem>
                              <MenuItem value='Aproched'>Aproched</MenuItem>
                              <MenuItem value='Relance 1'>Relance 1</MenuItem>
                              <MenuItem value='Relance 1'>Relance 2</MenuItem>
                              <MenuItem value='No Go Aproach'>No Go Aproach</MenuItem>
                              <MenuItem value='No Go Relance'>No Go Relance</MenuItem>
                              <MenuItem value='Evaluation'>Evaluation</MenuItem>
                              <MenuItem value='Screening'>Screening</MenuItem>
                              <MenuItem value='No fit'>No fit</MenuItem>
                              <MenuItem value='Dépôt'>Dépôt</MenuItem>
                              <MenuItem value='Culture Fit Interview'>Culture Fit Interview</MenuItem>
                              <MenuItem value='Technical Interview'>Technical Interview</MenuItem>
                              <MenuItem value='Interview no concluante'>Interview no concluante</MenuItem>
                              <MenuItem value='Offer'>Offer</MenuItem>
                              <MenuItem value='Hired'>Hired</MenuItem>
                              <MenuItem value='Refus'>Refus</MenuItem>
                            </Select>
                          )}
                        />
                        {errors.status && (
                          <FormHelperText sx={{ color: 'error.main' }} id='event-status-error'>
                            {errors.status.message}
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

export default CandidateViewLeft
