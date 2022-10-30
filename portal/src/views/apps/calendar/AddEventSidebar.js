// ** React Imports
import { useState, useEffect, forwardRef, useCallback, Fragment } from 'react';

// ** MUI Imports
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import FormControl from '@mui/material/FormControl';
import FormHelperText from '@mui/material/FormHelperText';
import Autocomplete from '@mui/material/Autocomplete';
import Chip from '@mui/material/Chip';

// ** Third Party Imports
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import DatePicker from 'react-datepicker';
import { useForm, Controller } from 'react-hook-form';
import { useUser } from '@auth0/nextjs-auth0';

// ** Icons Imports
import Close from 'mdi-material-ui/Close';
import DeleteOutline from 'mdi-material-ui/DeleteOutline';

// ** Styled Components
import DatePickerWrapper from 'src/@core/styles/libs/react-datepicker';

const capitalize = string => string && string[0].toUpperCase() + string.slice(1);

const defaultValues = {
  name: '',
  participants: [],
  description: '',
  startTime: new Date(),
  duration: 30,
  maxPerson: 4
};

const AddMeetingSidebar = props => {
  // ** Props
  const {
    store,
    dispatch,
    addMeeting,
    updateMeeting,
    drawerWidth,
    calendarApi,
    deleteMeeting,
    handleSelectMeeting,
    addMeetingSidebarOpen,
    handleAddMeetingSidebarToggle
  } = props;

  // ** States
  const [values, setValues] = useState(defaultValues);
  const { user } = useUser();

  const schema = yup.object().shape({
    name: yup.string().required('Name is a required field.'),
    participants: yup.array('prueba').of(yup.string().email(), 'test').min(1, 'Participants must have at least 1 items and valid emails.').required('required'),
    description: yup.string().required('Description is a required field.'),
    startTime: yup.date().required('Start Time is a required field.'),
    duration: yup.number().typeError('Duration must be a number.').min(15, 'Minimun time of meeting is 15 mins.').required('Duration is a required field.'),
    maxPerson: yup.number().typeError('Max must be a number.').min(2, 'The meeting should have at least 2 participants.').required('Max is a required field.')
  });

  const {
    control,
    setValue,
    clearErrors,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: defaultValues, resolver: yupResolver(schema) });

  const handleSidebarClose = async () => {
    setValues(defaultValues);
    clearErrors();
    dispatch(handleSelectMeeting(null));
    handleAddMeetingSidebarToggle();
  }

  const onSubmit = data => {
    const modifiedMeeting = {
      display: 'block',
      name: data.name,
      description: data.description.length ? data.description : undefined,
      participants: data.participants && data.participants.length ? data.participants : undefined,
      startTime: values.startTime,
      duration: data.duration,
      maxPerson: data.maxPerson,
      createdBy: user.email
    };
    if (store.selectedMeeting === null || (store.selectedMeeting !== null && !store.selectedMeeting.name.length)) {
      dispatch(addMeeting(modifiedMeeting));
    } else {
      dispatch(updateMeeting({ id: store.selectedMeeting.id, ...modifiedMeeting }));
    }
    calendarApi.refetchMeetings(user.email);
    handleSidebarClose();
  }

  const handleDeleteMeeting = () => {
    if (store.selectedMeeting) {
      dispatch(deleteMeeting(store.selectedMeeting.id));
    }

    // calendarApi.getMeetingById(store.selectedMeeting.id).remove()
    handleSidebarClose();
  }

  const handleStartTime = date => {
    if (date > values.startTime) {
      setValues({ ...values, startTime: new Date(date), duration: new Date(date) });
    }
  }

  const handleParticipants = (event, value) => {
    setValues({ ...values, participants: value });
  };

  const resetToStoredValues = useCallback(() => {
    if (store.selectedMeeting !== null) {
      const meeting = store.selectedMeeting;
      setValue('name', meeting.name || '');
      setValues({
        id: meeting.id || '',
        name: meeting.name || '',
        description: meeting.description || '',
        participants: meeting.participants || [],
        startTime: meeting.startTime !== null ? meeting.startTime : new Date(),
        duration: meeting.duration !== null ? meeting.duration : 30,
      });
    }
  }, [setValue, store.selectedMeeting]);

  const resetToEmptyValues = useCallback(() => {
    setValue('name', '')
    setValues(defaultValues)
  }, [setValue]);
  useEffect(() => {
    if (store.selectedMeeting !== null) {
      resetToStoredValues();
    } else {
      resetToEmptyValues();
    }
  }, [addMeetingSidebarOpen, resetToStoredValues, resetToEmptyValues, store.selectedMeeting]);

  const PickersComponent = forwardRef(({ ...props }, ref) => {
    return (
      <TextField
        inputRef={ref}
        fullWidth
        {...props}
        label={props.label || ''}
        sx={{ width: '100%' }}
        error={props.error}
      />
    )
  })

  const RenderSidebarFooter = () => {
    if (store.selectedMeeting === null || (store.selectedMeeting !== null && !store.selectedMeeting.name.length)) {
      return (
        <Fragment>
          <Button size='large' type='submit' variant='contained' sx={{ mr: 4 }}>
            Add
          </Button>
          <Button size='large' variant='outlined' color='secondary' onClick={resetToEmptyValues}>
            Reset
          </Button>
        </Fragment>
      )
    } else {
      return (
        <Fragment>
          <Button size='large' type='submit' variant='contained' sx={{ mr: 4 }}>
            Update
          </Button>
          <Button size='large' variant='outlined' color='secondary' onClick={resetToStoredValues}>
            Reset
          </Button>
        </Fragment>
      )
    }
  }

  return (
    <Drawer
      anchor='right'
      open={addMeetingSidebarOpen}
      onClose={handleSidebarClose}
      ModalProps={{ keepMounted: true }}
      sx={{ '& .MuiDrawer-paper': { width: ['100%', drawerWidth] } }}
    >
      <Box
        className='sidebar-header'
        sx={{
          display: 'flex',
          justifyContent: 'space-between',
          backgroundColor: 'background.default',
          p: theme => theme.spacing(3, 3.255, 3, 5.255)
        }}
      >
        <Typography variant='h6'>
          {store.selectedMeeting !== null && store.selectedMeeting.name.length ? 'Update Meeting' : 'Add Meeting'}
        </Typography>
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          {store.selectedMeeting !== null && store.selectedMeeting.name.length ? (
            <DeleteOutline
              fontSize='small'
              sx={{ cursor: 'pointer', mr: store.selectedMeeting !== null ? 2 : 0 }}
              onClick={handleDeleteMeeting}
            />
          ) : null}
          <Close fontSize='small' onClick={handleSidebarClose} sx={{ cursor: 'pointer' }} />
        </Box>
      </Box>
      <Box className='sidebar-body' sx={{ p: theme => theme.spacing(5, 6) }}>
        <DatePickerWrapper>
          <form onSubmit={handleSubmit(onSubmit)} noValidate autoComplete='off'>
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
            <FormControl fullWidth sx={{ mb: 6 }}>
              <Controller
                name='description'
                control={control}
                rules={{ required: true }}
                render={({ field: { value, onChange } }) => (
                  <TextField 
                    id='meeting-description'
                    rows={4}
                    multiline
                    label='Description'
                    value={value} 
                    onChange={onChange} 
                    error={Boolean(errors.description)} 
                  />
                )}
              />
              {errors.description && (
                <FormHelperText sx={{ color: 'error.main' }} id='event-description-error'>
                  {errors.description.message}
                </FormHelperText>
              )}
            </FormControl>
            <FormControl fullWidth sx={{ mb: 6 }}>
              <Controller
                name='participants'
                control={control}
                rules={{ required: true }}
                render={({ field: { ref, ...field }, fieldState: { error } }) => (
                  <Autocomplete
                    {...field}
                    multiple
                    id="tags-filled"
                    options={[]}
                    freeSolo
                    onChange={(event, value) => field.onChange(value)}
                    renderTags={(v, getTagProps) =>
                      v.map((option, index) => (
                        <Chip variant="outlined" label={option} color={Boolean(errors.participants) ? "error" : "default"} {...getTagProps({ index })} />
                      ))
                    }
                    renderInput={(params) => (
                      <TextField
                        {...params}
                        variant="outlined"
                        label="Participants"
                        helperText="Creator: Yasmany Molina Diaz"
                        inputRef={ref}
                        error={Boolean(errors.participants)}
                      />
                    )}
                  />                  
                )}
              />
              {errors.participants && (
                <FormHelperText sx={{ color: 'error.main' }} id='event-participants-error'>
                  {errors.participants.message || "Invalid emails."}
                </FormHelperText>
              )}
            </FormControl>
            <Box sx={{ mb: 6 }}>
              <DatePicker
                selectsStart
                id='meeting-start-time'
                endDate={values.duration}
                selected={values.startTime}
                startDate={values.startTime}
                showTimeSelect={true}
                dateFormat='MM-dd-yyyy hh:mm'
                customInput={<PickersComponent label='Start Time' registername='startTime' />}
                onChange={date => setValues({ ...values, startTime: new Date(date) })}
                onSelect={handleStartTime}
              />
            </Box>
            <FormControl fullWidth sx={{ mb: 6 }}>
              <Controller
                name='duration'
                control={control}
                rules={{ required: true }}
                render={({ field: { value, onChange } }) => (
                  <TextField
                    type='number'
                    label='Duration'
                    value={value}
                    onChange={onChange}
                    error={Boolean(errors.duration)}
                    InputProps={{ inputProps: { min: 15 } }}
                  />
                )}
              />
              {errors.duration && (
                <FormHelperText sx={{ color: 'error.main' }} id='event-duration-error'>
                  {errors.duration.message}
                </FormHelperText>
              )}
            </FormControl>
            <FormControl fullWidth sx={{ mb: 6 }}>
              <Controller
                name='maxPerson'
                control={control}
                rules={{ required: true }}
                render={({ field: { value, onChange } }) => (
                  <TextField
                    type='number'
                    label='Maximum of participants'
                    value={value}
                    onChange={onChange}
                    error={Boolean(errors.maxPerson)}
                    InputProps={{ inputProps: { min: 2 } }}
                  />
                )}
              />
              {errors.maxPerson && (
                <FormHelperText sx={{ color: 'error.main' }} id='event-max-person-error'>
                  {errors.maxPerson.message}
                </FormHelperText>
              )}
            </FormControl>
            <Box sx={{ display: 'flex', alignItems: 'center' }}>
              <RenderSidebarFooter />
            </Box>
          </form>
        </DatePickerWrapper>
      </Box>
    </Drawer>
  )
}

export default AddMeetingSidebar;
