// ** Redux Imports
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

// ** Axios Imports
import axios from 'axios'

// ** Fetch Meeting
export const fetchMeeting = createAsyncThunk('appCall/fetchMeeting', async (code) => {
  const response = await fetch(encodeURI('/api/call/' + code), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// ** Fetch User Profile
export const fetchUserProfile = createAsyncThunk('appCall/fetchUserProfile', async () => {
  const response = await axios.get('/apps/call/users/profile-user')

  return response.data
})

// ** Fetch Calls & Contacts
export const fetchCallsContacts = createAsyncThunk('appCall/fetchCallsContacts', async () => {
  const response = await axios.get('/apps/call/calls-and-contacts')

  return response.data
})

// ** Select Call
export const selectCall = createAsyncThunk('appCall/selectCall', async (id, { dispatch }) => {
  const response = await axios.get('/apps/call/get-call', {
    params: {
      id
    }
  })
  await dispatch(fetchCallsContacts())

  return response.data
})

// ** Send Msg
export const sendMsg = createAsyncThunk('appCall/sendMsg', async (obj, { dispatch }) => {
  const response = await axios.post('/apps/call/send-msg', {
    data: {
      obj
    }
  })
  if (obj.contact) {
    await dispatch(selectCall(obj.contact.id))
  }
  await dispatch(fetchCallsContacts())

  return response.data
})

export const appCallSlice = createSlice({
  name: 'appCall',
  initialState: {
    calls: null,
    contacts: null,
    userProfile: null,
    selectedCall: null,
    currentCall: null
  },
  reducers: {
    removeSelectedCall: state => {
      state.selectedCall = null
    }
  },
  extraReducers: builder => {
    builder.addCase(fetchUserProfile.fulfilled, (state, action) => {
      state.userProfile = action.payload
    })
    builder.addCase(fetchCallsContacts.fulfilled, (state, action) => {
      state.contacts = action.payload.contacts
      state.calls = action.payload.callsContacts
    })
    builder.addCase(selectCall.fulfilled, (state, action) => {
      state.selectedCall = action.payload
    })
    builder.addCase(fetchMeeting.fulfilled, (state, action) => {
      if (action?.payload) {
        state.currentCall = action.payload;
      } else {
        state.currentCall = null;
      }
    })
  }
})

export const { removeSelectedCall } = appCallSlice.actions

export default appCallSlice.reducer
