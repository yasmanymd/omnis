import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

// ** Axios Imports
import axios from 'axios'

// ** Fetch Candidates
export const fetchCandidates = createAsyncThunk('appCandidates/fetchCandidatess', async () => {
  const response = await fetch(encodeURI('/api/candidates'), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// TO REMOVE
// ** Fetch Users
export const fetchData = createAsyncThunk('appUsers/fetchData', async params => {
  const response = await axios.get('/apps/candidates/list', {
    params
  })

  return response.data
})

// ** Add User
export const addUser = createAsyncThunk('appUsers/addUser', async (data, { getState, dispatch }) => {
  const response = await axios.post('/apps/candidates/add-user', {
    data
  })
  dispatch(fetchData(getState().user.params))

  return response.data
})

// ** Delete User
export const deleteUser = createAsyncThunk('appUsers/deleteUser', async (id, { getState, dispatch }) => {
  const response = await axios.delete('/apps/candidates/delete', {
    data: id
  })
  dispatch(fetchData(getState().user.params))

  return response.data
})

export const appCandidatesSlice = createSlice({
  name: 'appCandidates',
  initialState: {
    data: []

  },
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchCandidates.fulfilled, (state, action) => {
      state.data = action.payload?.candidates || []
    })
  }
})

export default appCandidatesSlice.reducer
