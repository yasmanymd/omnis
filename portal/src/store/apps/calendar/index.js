// ** Redux Imports
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

import toast from 'react-hot-toast';
import ErrorDetails from 'src/layouts/components/ErrorDetails';

// ** Fetch Meetings
export const fetchMeetings = createAsyncThunk('appCalendar/fetchMeetings', async () => {
  const response = await fetch(encodeURI('/api/meetings'), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data.meetings;
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
      "start_time": +new Date(meeting.startTime)
    })
  });
  const result = await response.json();
  dispatch(fetchMeetings());
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error creating meeting.' errors={result.errors} />);
  } else {
    toast.success('Meeting created.');
  }

  return result.data.meeting;
})

// ** Update Meeting
export const updateMeeting = createAsyncThunk('appCalendar/updateMeeting', async (meeting, { dispatch }) => {
  const response = await fetch(encodeURI('/api/meetings/' + meeting._id), {
    method: 'PUT',
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
      "start_time": +new Date(meeting.startTime)
    })
  });

  const result = await response.json();
  dispatch(fetchMeetings());
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error updating meeting.' errors={result.errors} />);
  } else {
    toast.success('Meeting updated.');
  }

  return result.data.meeting;
})

// ** Delete Meeting
export const deleteMeeting = createAsyncThunk('appCalendar/deleteMeeting', async (id, { dispatch }) => {
  const response = await fetch(encodeURI('/api/meetings/' + id), {
    method: 'DELETE',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });

  const result = await response.json();
  dispatch(fetchMeetings());
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error removing meeting.' errors={result.errors} />);
  } else {
    toast.success('Meeting removed.');
  }

  return result.data.meeting;
})

export const appCalendarSlice = createSlice({
  name: 'appCalendar',
  initialState: {
    meetings: [],
    selectedMeeting: null
  },
  reducers: {
    handleSelectMeeting: (state, action) => {
      state.selectedMeeting = action.payload?._def?.extendedProps?.ref;
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
