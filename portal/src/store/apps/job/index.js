import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import toast from 'react-hot-toast';
import ErrorDetails from 'src/layouts/components/ErrorDetails';

// ** Fetch Jobs
export const fetchJobs = createAsyncThunk('appJobs/fetchJobs', async () => {
  const response = await fetch(encodeURI('/api/jobs'), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// ** Fetch Job
export const fetchJob = createAsyncThunk('appJobs/fetchJob', async (id) => {
  const response = await fetch(encodeURI('/api/jobs/' + id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// ** Update Job
export const updateJob = createAsyncThunk('appJobs/updateJob', async (job, { dispatch }) => {
  const response = await fetch(encodeURI('/api/jobs/' + job._id), {
    method: 'PUT',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "name": job.name,
      "description": job.description,
      "contacts": job.contacts || []
    })
  });

  dispatch(fetchJob(job._id));

  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error updating job.' errors={result.errors} />);
  } else {
    toast.success('Job updated.');
  }
  return result.data;
})

// ** Fetch Documents
export const fetchDocuments = createAsyncThunk('appJobs/fetchDocuments', async (job_id) => {
  const response = await fetch(encodeURI('/api/docs/filter?entity_id=' + job_id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result;
})

// ** Delete Document
export const deleteDocument = createAsyncThunk('appJobs/deleteDocument', async ({ job_id, doc }, { dispatch }) => {
  const response = await fetch(encodeURI('/api/docs/' + job_id + '/' + doc), {
    method: 'DELETE',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });

  const result = await response.json();
  dispatch(fetchDocuments(job_id));
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error removing document.' errors={result.errors} />);
  } else {
    toast.success('Document removed.');
  }

  return result.data;
})

export const appJobsSlice = createSlice({
  name: 'appJobs',
  initialState: {
    jobs: [],
    job: null,
    documents: []
  },
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchJobs.fulfilled, (state, action) => {
      state.jobs = action.payload || []
    })
    builder.addCase(fetchJob.fulfilled, (state, action) => {
      state.job = action.payload || null
    })
    builder.addCase(fetchDocuments.fulfilled, (state, action) => {
      state.documents = action.payload || []
    })
  }
})

export default appJobsSlice.reducer
