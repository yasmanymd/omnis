// ** Redux Imports
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

// ** Axios Imports
import axios from 'axios';
import { RewindOutline } from 'mdi-material-ui';

import toast from 'react-hot-toast';
import ErrorDetails from 'src/layouts/components/ErrorDetails';

// ** Fetch Meetings
export const fetchMeetings = createAsyncThunk('appCalendar/fetchMeetings', async () => {
  const response = await axios.get('/apps/calendar/meetings');
  return response.data;
})

// ** Add Meetings
export const addMeeting = createAsyncThunk('appCalendar/addMeeting', async (meeting, { dispatch }) => {
  const response = await fetch('/api/meetings', {
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "name": meeting.name,
      "description": meeting.description,
      "participants": meeting.participants,
      "duration": meeting.duration,
      "max_person": meeting.maxPerson,
      "start_time": +new Date(meeting.startTime),
      "created_by": meeting.createdBy
    })
  });    
  const result = await response.json();
  await dispatch(fetchMeetings());
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error creating meeting.' errors={result.errors} />);
  } else {
    toast.success('Meeting created');
  }
  
  return result.data.meeting;
})

// ** Update Meeting
export const updateMeeting = createAsyncThunk('appCalendar/updateMeeting', async (meeting, { dispatch }) => {
  const response = await axios.post('/apps/calendar/update-meeting', {
    data: {
      meeting
    }
  });
  await dispatch(fetchEvents());

  return response.data.meeting;
})

// ** Delete Meeting
export const deleteMeeting = createAsyncThunk('appCalendar/deleteMeeting', async (id, { dispatch }) => {
  const response = await axios.delete('/apps/calendar/remove-meeting', {
    params: { id }
  });
  await dispatch(fetchEvents());

  return response.data;
})

export const appCalendarSlice = createSlice({
  name: 'appCalendar',
  initialState: {
    meetings: [],
    selectedMeeting: null
  },
  reducers: {
    handleSelectMeeting: (state, action) => {
      state.selectedMeeting = action.payload;
    }
  },
  extraReducers: builder => {
    builder.addCase(fetchMeetings.fulfilled, (state, action) => {
      state.meetings = action.payload;
    })
  }
});

export const { handleSelectMeeting } = appCalendarSlice.actions;

export default appCalendarSlice.reducer;
