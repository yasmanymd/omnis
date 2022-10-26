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
import DatePicker from 'react-datepicker';
import { useForm, Controller } from 'react-hook-form';

// ** Icons Imports
import Close from 'mdi-material-ui/Close';
import DeleteOutline from 'mdi-material-ui/DeleteOutline';

// ** Styled Components
import DatePickerWrapper from 'src/@core/styles/libs/react-datepicker';

const capitalize = string => string && string[0].toUpperCase() + string.slice(1);

const defaultState = {
  name: '',
  participants: [],
  description: '',
  endTime: new Date(),
  startTime: new Date(),
  max: 4
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
  const [values, setValues] = useState(defaultState);

  const {
    control,
    setValue,
    clearErrors,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: { name: '' } });

  const handleSidebarClose = async () => {
    setValues(defaultState);
    clearErrors();
    dispatch(handleSelectMeeting(null));
    handleAddMeetingSidebarToggle();
  }

  const onSubmit = data => {
    const modifiedMeeting = {
      display: 'block',
      name: data.name,
      startTime: values.startTime,
      endTime: values.endTime,
      extendedProps: {
        participants: values.participants && values.participants.length ? values.participants : undefined,
        description: values.description.length ? values.description : undefined
      }
    };
    if (store.selectedMeeting === null || (store.selectedMeeting !== null && !store.selectedMeeting.name.length)) {
      dispatch(addMeeting(modifiedMeeting));
    } else {
      dispatch(updateMeeting({ id: store.selectedMeeting.id, ...modifiedMeeting }));
    }
    calendarApi.refetchMeetings();
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
      setValues({ ...values, startTime: new Date(date), endTime: new Date(date) });
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
        participants: meeting.extendedProps.participants || [],
        description: meeting.extendedProps.description || '',
        endTime: meeting.endTime !== null ? meeting.endTime : meeting.startTime,
        startTime: meeting.startTime !== null ? meeting.startTime : new Date()
      });
    }
  }, [setValue, store.selectedMeeting]);

  const resetToEmptyValues = useCallback(() => {
    setValue('name', '')
    setValues(defaultState)
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
          <form onSubmit={handleSubmit(onSubmit)} autoComplete='off'>
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
                  This field is required
                </FormHelperText>
              )}
            </FormControl>
            <TextField
              rows={4}
              multiline
              fullWidth
              sx={{ mb: 6 }}
              label='Description'
              id='meeting-description'
              value={values.description}
              onChange={e => setValues({ ...values, description: e.target.value })}
            />
            <Box sx={{ mb: 6 }}>
              <Autocomplete
                multiple
                id="tags-filled"
                options={[]}
                values={values.participants}
                freeSolo
                onChange={handleParticipants}
                renderTags={(value, getTagProps) =>
                  value.map((option, index) => (
                    <Chip variant="outlined" label={option} {...getTagProps({ index })} />
                  ))
                }
                renderInput={(params) => (
                  <TextField
                    {...params}
                    variant="outlined"
                    label="Participants"
                    helperText="Creator: Yasmany Molina Diaz"
                  />
                )}
              />
            </Box>
            <Box sx={{ mb: 6 }}>
              <DatePicker
                selectsStart
                id='meeting-start-time'
                endDate={values.endTime}
                selected={values.startTime}
                startDate={values.startTime}
                showTimeSelect={true}
                dateFormat='MM-dd-yyyy hh:mm'
                customInput={<PickersComponent label='Start Time' registername='startTime' />}
                onChange={date => setValues({ ...values, startTime: new Date(date) })}
                onSelect={handleStartTime}
              />
            </Box>
            <Box sx={{ mb: 6 }}>
              <DatePicker
                selectsEnd
                id='meeting-end-time'
                endDate={values.endTime}
                selected={values.endTime}
                minDate={values.startTime}
                startDate={values.startTime}
                showTimeSelect={true}
                dateFormat='MM-dd-yyyy hh:mm'
                customInput={<PickersComponent label='End Time' registername='endTime' />}
                onChange={date => setValues({ ...values, endTime: new Date(date) })}
              />
            </Box>
            <TextField
              fullWidth
              type='number'
              sx={{ mb: 6 }}
              label='Max'
              defaultValue={values.max}
              InputProps={{ inputProps: { min: 2 } }}
              onChange={e => setValues({ ...values, max: e.target.value })}
            />
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
