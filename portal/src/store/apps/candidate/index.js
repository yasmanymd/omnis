import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

import toast from 'react-hot-toast';
import ErrorDetails from 'src/layouts/components/ErrorDetails';

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

// ** Fetch Candidate
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

// ** Update Candidate
export const updateCandidate = createAsyncThunk('appCandidates/updateCandidate', async (candidate, { dispatch }) => {
  const response = await fetch(encodeURI('/api/candidates/' + candidate._id), {
    method: 'PUT',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "name": candidate.name,
      "title": candidate.title,
      "status": candidate.status
    })
  });

  dispatch(fetchCandidate(candidate._id));

  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error updating candidate.' errors={result.errors} />);
  } else {
    toast.success('Candidate updated.');
  }
  return result.data;
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
      state.candidates = action.payload || []
    })
    builder.addCase(fetchCandidate.fulfilled, (state, action) => {
      state.candidate = action.payload || null
    })
  }
})

export default appCandidatesSlice.reducer
