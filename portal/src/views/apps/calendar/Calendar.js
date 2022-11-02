// ** React Import
import { useEffect, useRef } from 'react';

// ** Full Calendar & it's Plugins
import FullCalendar from '@fullcalendar/react';
import listPlugin from '@fullcalendar/list';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';

// ** Icons Imports
import Menu from 'mdi-material-ui/Menu';

const blankMeeting = {
  name: '',
  participants: [],
  description: '',
  startTime: new Date(+new Date() - (+new Date()%(3600000)) + 3600000),
  duration: 30,
  maxPerson: 4
};

const Calendar = props => {
  // ** Props
  const {
    store,
    dispatch,
    direction,
    updateMeeting,
    calendarApi,
    setCalendarApi,
    handleSelectMeeting,
    handleLeftSidebarToggle,
    handleAddMeetingSidebarToggle
  } = props;

  // ** Refs
  const calendarRef = useRef();
  useEffect(() => {
    if (calendarApi === null) {
      // @ts-ignore
      setCalendarApi(calendarRef.current.getApi());
    }
  }, [calendarApi, setCalendarApi]);
  if (store) {
    // ** calendarOptions(Props)
    const calendarOptions = {
      events: store.meetings.length ? 
        store.meetings.map(item => 
          { 
            return {
              id: item._id, 
              title: item.name, 
              start: new Date(item.start_time), 
              extendedProps: {
                ref: item
              }
            }
          }
        ) : [],
      plugins: [interactionPlugin, dayGridPlugin, timeGridPlugin, listPlugin],
      initialView: 'dayGridMonth',
      noEventsContent: 'No meetings to display',
      headerToolbar: {
        start: 'sidebarToggle, prev, next, title',
        end: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
      },

      /*
            Enable dragging and resizing event
            ? Docs: https://fullcalendar.io/docs/editable
          */
      editable: true,

      /*
            Enable resizing event from start
            ? Docs: https://fullcalendar.io/docs/eventResizableFromStart
          */
      eventResizableFromStart: true,

      /*
            Automatically scroll the scroll-containers during event drag-and-drop and date selecting
            ? Docs: https://fullcalendar.io/docs/dragScroll
          */
      dragScroll: true,

      /*
            Max number of events within a given day
            ? Docs: https://fullcalendar.io/docs/dayMaxEvents
          */
      dayMaxEvents: 2,

      /*
            Determines if day names and week names are clickable
            ? Docs: https://fullcalendar.io/docs/navLinks
          */
      navLinks: true,
      eventClassNames({ event: calendarEvent }) {
        return [
          // Background Color
          `bg-primary`
        ];
      },
      eventClick({ event: clickedEvent }) {
        dispatch(handleSelectMeeting(clickedEvent));
        handleAddMeetingSidebarToggle();

        // * Only grab required field otherwise it goes in infinity loop
        // ! Always grab all fields rendered by form (even if it get `undefined`) otherwise due to Vue3/Composition API you might get: "object is not extensible"
        // event.value = grabEventDataFromEventApi(clickedEvent)
        // isAddNewEventSidebarActive.value = true
      },
      customButtons: {
        sidebarToggle: {
          text: <Menu />,
          click() {
            handleLeftSidebarToggle();
          }
        }
      },
      dateClick(info) {
        const meeting = { ...blankMeeting };
        meeting.startTime = info.date;

        // @ts-ignore
        dispatch(handleSelectMeeting(meeting));
        handleAddMeetingSidebarToggle();
      },

      /*
            Handle event drop (Also include dragged event)
            ? Docs: https://fullcalendar.io/docs/eventDrop
            ? We can use `eventDragStop` but it doesn't return updated event so we have to use `eventDrop` which returns updated event
          */
      eventDrop({ event: droppedEvent }) {
        dispatch(updateMeeting(droppedEvent));
      },

      /*
            Handle event resize
            ? Docs: https://fullcalendar.io/docs/eventResize
          */
      eventResize({ event: resizedEvent }) {
        dispatch(updateMeeting(resizedEvent));
      },
      ref: calendarRef,

      // Get direction from app state (store)
      direction
    }

    // @ts-ignore
    return <FullCalendar {...calendarOptions} />
  } else {
    return null
  }
};

export default Calendar;
