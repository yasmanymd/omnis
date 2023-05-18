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

// ** Icons Imports
import Close from 'mdi-material-ui/Close';
import DeleteOutline from 'mdi-material-ui/DeleteOutline';

// ** Styled Components
import DatePickerWrapper from 'src/@core/styles/libs/react-datepicker';
import { fetchMeetings } from '../../../store/apps/calendar';

const defaultValues = {
  name: '',
  participants: [],
  description: '',
  startTime: new Date(+new Date() - (+new Date() % (3600000)) + 3600000),
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
    deleteMeeting,
    handleSelectMeeting,
    addMeetingSidebarOpen,
    handleAddMeetingSidebarToggle
  } = props;

  // ** States
  const [values, setValues] = useState(defaultValues);
  const user = {};

  const schema = yup.object().shape({
    name: yup.string().required('Name is a required field.'),
    participants: yup.array().of(yup.string().email()).min(1, 'Participants must have at least 1 items and valid emails.').required('Participants is a required field.'),
    description: yup.string().required('Description is a required field.'),
    startTime: yup.date().required('Start Time is a required field.'),
    duration: yup.number().typeError('Duration must be a number.').min(15, 'Minimun time of meeting is 15 mins.').required('Duration is a required field.'),
    maxPerson: yup.number().typeError('Max must be a number.').min(2, 'The meeting should have at least 2 participants.').required('Max is a required field.')
  }).required();

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
      name: data.name,
      description: data.description.length ? data.description : undefined,
      participants: data.participants && data.participants.length ? data.participants : undefined,
      startTime: values.startTime,
      duration: data.duration,
      maxPerson: data.maxPerson
    };
    if (!store.selectedMeeting || (!store.selectedMeeting && !store.selectedMeeting.name.length)) {
      dispatch(addMeeting(modifiedMeeting));
    } else {
      dispatch(updateMeeting({ ...modifiedMeeting, _id: store.selectedMeeting._id }));
    }
    dispatch(fetchMeetings());
    handleSidebarClose();
  }

  const handleDeleteMeeting = async () => {
    if (store.selectedMeeting) {
      await dispatch(deleteMeeting(store.selectedMeeting._id));
      dispatch(fetchMeetings());
    }

    handleSidebarClose();
  }

  const handleStartTime = date => {
    if (date > values.startTime) {
      setValues({ ...values, startTime: new Date(date) });
    }
  }

  const resetToStoredValues = useCallback(() => {
    if (store.selectedMeeting) {
      const meeting = store.selectedMeeting;
      setValue('name', meeting.name || defaultValues.name);
      setValue('description', meeting.description || defaultValues.description);
      setValue('participants', meeting.participants || defaultValues.participants);
      setValue('startTime', new Date(meeting.start_time || defaultValues.startTime));
      setValue('duration', meeting.duration || defaultValues.duration);
      setValue('maxPerson', meeting.max_person || defaultValues.maxPerson);
      setValues({
        id: meeting._id || '',
        name: meeting.name || defaultValues.name,
        description: meeting.description || defaultValues.description,
        participants: meeting.participants || defaultValues.participants,
        startTime: new Date(meeting.start_time || defaultValues.startTime),
        duration: meeting.duration || defaultValues.duration,
        maxPerson: meeting.max_person || defaultValues.maxPerson
      });
    }
  }, [setValue, store.selectedMeeting]);

  const resetToEmptyValues = useCallback(() => {
    setValue('name', defaultValues.name);
    setValue('description', defaultValues.name);
    setValue('participants', defaultValues.participants);
    setValue('startTime', defaultValues.startTime);
    setValue('duration', defaultValues.duration);
    setValue('maxPerson', defaultValues.maxPerson);
    setValues(defaultValues);
  }, [setValue]);
  useEffect(() => {
    if (store.selectedMeeting) {
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
    if (!store.selectedMeeting || (!store.selectedMeeting && !store.selectedMeeting.name.length)) {
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
          {store.selectedMeeting && store.selectedMeeting.name.length ? 'Update Meeting' : 'Add Meeting'}
        </Typography>
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
          {store.selectedMeeting && store.selectedMeeting.name.length ? (
            <DeleteOutline
              fontSize='small'
              sx={{ cursor: 'pointer', mr: store.selectedMeeting ? 2 : 0 }}
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
                        helperText={"Creator: " + user.name}
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
                selected={values.startTime}
                startDate={values.startTime}
                showTimeSelect={true}
                dateFormat='MM-dd-yyyy hh:mm aa'
                timeIntervals={15}
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
