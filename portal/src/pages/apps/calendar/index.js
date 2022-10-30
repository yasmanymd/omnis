// ** React Imports
import { useEffect, useState } from 'react';

// ** MUI Imports
import Box from '@mui/material/Box';
import useMediaQuery from '@mui/material/useMediaQuery';

// ** Redux Imports
import { useDispatch, useSelector } from 'react-redux';

// ** Hooks
import { useSettings } from 'src/@core/hooks/useSettings';
import { useUser } from '@auth0/nextjs-auth0';

// ** FullCalendar & App Components Imports
import Calendar from 'src/views/apps/calendar/Calendar';
import SidebarLeft from 'src/views/apps/calendar/SidebarLeft';
import CalendarWrapper from 'src/@core/styles/libs/fullcalendar';
import AddMeetingSidebar from 'src/views/apps/calendar/AddEventSidebar';

// ** Actions
import {
  addMeeting,
  fetchMeetings,
  deleteMeeting,
  updateMeeting,
  handleSelectMeeting
} from 'src/store/apps/calendar';

// ** Third Party Styles Imports
import 'react-datepicker/dist/react-datepicker.css';

const AppCalendar = () => {
  // ** States
  const [calendarApi, setCalendarApi] = useState(null);
  const [leftSidebarOpen, setLeftSidebarOpen] = useState(false);
  const [addMeetingSidebarOpen, setAddMeetingSidebarOpen] = useState(false);

  // ** Hooks
  const { settings } = useSettings();
  const dispatch = useDispatch();
  const store = useSelector(state => state.calendar);
  const { user } = useUser();

  // ** Vars
  const leftSidebarWidth = 260;
  const addMeetingSidebarWidth = 400;
  const { skin, direction } = settings;
  const mdAbove = useMediaQuery(theme => theme.breakpoints.up('md'));
  useEffect(() => {
    dispatch(fetchMeetings(user.email));
  }, [dispatch, null]);
  const handleLeftSidebarToggle = () => setLeftSidebarOpen(!leftSidebarOpen)
  const handleAddMeetingSidebarToggle = () => setAddMeetingSidebarOpen(!addMeetingSidebarOpen)

  return (
    <CalendarWrapper
      className='app-calendar'
      sx={{
        boxShadow: skin === 'bordered' ? 0 : 6,
        ...(skin === 'bordered' && { border: theme => `1px solid ${theme.palette.divider}` })
      }}
    >
      <SidebarLeft
        store={store}
        mdAbove={mdAbove}
        dispatch={dispatch}
        leftSidebarOpen={leftSidebarOpen}
        leftSidebarWidth={leftSidebarWidth}
        handleSelectMeeting={handleSelectMeeting}
        handleLeftSidebarToggle={handleLeftSidebarToggle}
        handleAddMeetingSidebarToggle={handleAddMeetingSidebarToggle}
      />
      <Box
        sx={{
          p: 5,
          pb: 0,
          flexGrow: 1,
          borderRadius: 1,
          boxShadow: 'none',
          backgroundColor: 'background.paper',
          ...(mdAbove ? { borderTopLeftRadius: 0, borderBottomLeftRadius: 0 } : {})
        }}
      >
        <Calendar
          store={store}
          dispatch={dispatch}
          direction={direction}
          updateMeeting={updateMeeting}
          calendarApi={calendarApi}
          setCalendarApi={setCalendarApi}
          handleSelectMeeting={handleSelectMeeting}
          handleLeftSidebarToggle={handleLeftSidebarToggle}
          handleAddMeetingSidebarToggle={handleAddMeetingSidebarToggle}
        />
      </Box>
      <AddMeetingSidebar
        store={store}
        dispatch={dispatch}
        addMeeting={addMeeting}
        updateMeeting={updateMeeting}
        deleteMeeting={deleteMeeting}
        calendarApi={calendarApi}
        drawerWidth={addMeetingSidebarWidth}
        handleSelectMeeting={handleSelectMeeting}
        addMeetingSidebarOpen={addMeetingSidebarOpen}
        handleAddMeetingSidebarToggle={handleAddMeetingSidebarToggle}
      />
    </CalendarWrapper>
  )
};

export default AppCalendar;
