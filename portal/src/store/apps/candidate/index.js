import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

// ** Axios Imports
import axios from 'axios'

// ** Fetch Candidates
export const fetchCandidates = createAsyncThunk('appCandidates/fetchCandidates', async () => {
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

export const fetchCandidate = createAsyncThunk('appCandidates/fetchCandidate', async (id) => {
  const response = await fetch(encodeURI('/api/candidates/' + id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
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
    candidates: [],
    candidate: null
  },
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchCandidates.fulfilled, (state, action) => {
      state.candidates = action.payload?.candidates || []
    })
    builder.addCase(fetchCandidate.fulfilled, (state, action) => {
      state.candidate = action.payload?.candidate || null
    })
  }
})

export default appCandidatesSlice.reducer
