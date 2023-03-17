import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import toast from 'react-hot-toast';
import ErrorDetails from 'src/layouts/components/ErrorDetails';
import { fetchClients as fc } from '../client';

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

export const fetchClients = fc;

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
      "tags": job.tags || [],
      "contacts": job.contacts || {}
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

// ** Create Job
export const createJob = createAsyncThunk('appJobs/createJob', async (job, { dispatch }) => {
  const response = await fetch(encodeURI('/api/jobs'), {
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "title": job.title,
      "description": job.description,
      "tags": job.tags || [],
      "contacts": job.contacts || {},
      "client_id": job.client_id,
      "workflow_template_id": job.workflow_template_id
    })
  });

  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error creating job.' errors={result.errors} />);
  } else {
    dispatch(fetchJobs());
    toast.success('Job created.');
  }
  return result.data;
})

// ** Fetch Documents
export const fetchDocuments = createAsyncThunk('appJobs/fetchDocuments', async (entity_id) => {
  const response = await fetch(encodeURI('/api/docs/filter?entity_id=' + entity_id), {
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
export const deleteDocument = createAsyncThunk('appJobs/deleteDocument', async ({ entity_id, doc }, { dispatch }) => {
  const response = await fetch(encodeURI('/api/docs/' + entity_id + '/' + doc), {
    method: 'DELETE',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });

  const result = await response.json();
  dispatch(fetchDocuments(entity_id));
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error removing document.' errors={result.errors} />);
  } else {
    toast.success('Document removed.');
  }

  return result.data;
})

// ** Fetch Workflow Templates
export const fetchWorkflowsTemplates = createAsyncThunk('appClients/fetchWorkflowTemplates', async () => {
  const response = await fetch(encodeURI('/api/workflows/templates'), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// ** Fetch Workflow
export const fetchWorkflow = createAsyncThunk('appJobs/fetchWorkflow', async (id) => {
  const response = await fetch(encodeURI('/api/workflows/' + id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

export const appJobsSlice = createSlice({
  name: 'appJobs',
  initialState: {
    jobs: [],
    job: null,
    documents: [],
    clients: [],
    workflowTemplates: [],
    workflow: null
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
    builder.addCase(fetchClients.fulfilled, (state, action) => {
      state.clients = action.payload || []
    })
    builder.addCase(fetchWorkflow.fulfilled, (state, action) => {
      state.workflow = action.payload || null
    })
  }
})

export default appJobsSlice.reducer
