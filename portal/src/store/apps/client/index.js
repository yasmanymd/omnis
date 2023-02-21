import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'
import toast from 'react-hot-toast';
import ErrorDetails from 'src/layouts/components/ErrorDetails';

// ** Fetch Clients
export const fetchClients = createAsyncThunk('appClients/fetchClients', async () => {
  const response = await fetch(encodeURI('/api/clients'), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// ** Fetch Client
export const fetchClient = createAsyncThunk('appClients/fetchClient', async (id, { dispatch }) => {
  const response = await fetch(encodeURI('/api/clients/' + id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  if (result.data) {
    dispatch(fetchDocuments(result.data._id));
  }
  return result.data;
})

// ** Create Client
export const createClient = createAsyncThunk('appClients/createClient', async (client, { dispatch }) => {
  const response = await fetch(encodeURI('/api/clients'), {
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "name": client.name,
      "description": client.description,
      "contacts": client.contacts || {}
    })
  });

  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error creating client.' errors={result.errors} />);
  } else {
    dispatch(fetchClients());
    toast.success('Client created.');
  }
  return result.data;
})

// ** Update Client
export const updateClient = createAsyncThunk('appClients/updateClient', async (client, { dispatch }) => {
  const response = await fetch(encodeURI('/api/clients/' + client._id), {
    method: 'PUT',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "name": client.name,
      "description": client.description,
      "contacts": client.contacts || {}
    })
  });

  dispatch(fetchClient(client._id));

  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error updating client.' errors={result.errors} />);
  } else {
    toast.success('Client updated.');
  }
  return result.data;
})

// ** Fetch Documents
export const fetchDocuments = createAsyncThunk('appClients/fetchDocuments', async (entity_id) => {
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
export const deleteDocument = createAsyncThunk('appClients/deleteDocument', async ({ entity_id, doc }, { dispatch }) => {
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

export const appClientsSlice = createSlice({
  name: 'appClients',
  initialState: {
    clients: [],
    client: null,
    documents: []
  },
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchClients.fulfilled, (state, action) => {
      state.clients = action.payload || []
    })
    builder.addCase(fetchClient.fulfilled, (state, action) => {
      state.client = action.payload || null
    })
    builder.addCase(fetchDocuments.fulfilled, (state, action) => {
      state.documents = action.payload || []
    })
  }
})

export default appClientsSlice.reducer
