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
export const fetchCandidate = createAsyncThunk('appCandidates/fetchCandidate', async (id, { dispatch }) => {
  const response = await fetch(encodeURI('/api/candidates/' + id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  if (result.data) {
    dispatch(fetchNotes(result.data._id));
    dispatch(fetchDocuments(result.data._id));
  }
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
      "tags": candidate.tags || [],
      "contacts": candidate.contacts || {},
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

// ** Create Candidate
export const createCandidate = createAsyncThunk('appCandidates/createCandidate', async (candidate, { dispatch }) => {
  const response = await fetch(encodeURI('/api/candidates'), {
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "name": candidate.name,
      "title": candidate.title,
      "status": "None",
      "contacts": {}
    })
  });

  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error creating candidate.' errors={result.errors} />);
  } else {
    dispatch(fetchCandidates());
    toast.success('Candidate created.');
  }
  return result.data;
})

// ** Fetch Notes
export const fetchNotes = createAsyncThunk('appCandidates/fetchNotes', async (candidate_id) => {
  const response = await fetch(encodeURI('/api/notes/filter?candidate_id=' + candidate_id), {
    method: 'GET',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    }
  });
  const result = await response.json();
  return result.data;
})

// ** Fetch Documents
export const fetchDocuments = createAsyncThunk('appCandidates/fetchDocuments', async (entity_id) => {
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
export const deleteDocument = createAsyncThunk('appCandidates/deleteDocument', async ({ entity_id, doc }, { dispatch }) => {
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

// ** Fetch Notes
export const createNote = createAsyncThunk('appCandidates/createNote', async (note, { dispatch }) => {
  const response = await fetch(encodeURI('/api/notes'), {
    method: 'POST',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "note": note.note,
      "candidate_id": note.candidate_id
    })
  });
  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error updating candidate.' errors={result.errors} />);
  } else {
    dispatch(fetchNotes(note.candidate_id));
    toast.success('Candidate updated.');
  }
  return result.data;
})

export const updateNote = createAsyncThunk('appCandidates/updateNote', async (note, { dispatch }) => {
  const response = await fetch(encodeURI('/api/notes/' + note._id), {
    method: 'PUT',
    headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      "note": note.note,
      "candidate_id": note.candidate_id
    })
  });
  const result = await response.json();
  if (result?.errors) {
    toast.error(<ErrorDetails message='Error updating note.' errors={result.errors} />);
  } else {
    dispatch(fetchNotes(note.candidate_id));
    toast.success('Note updated.');
  }
  return result.data;
})

export const appCandidatesSlice = createSlice({
  name: 'appCandidates',
  initialState: {
    candidates: [],
    candidate: null,
    notes: [],
    documents: []
  },
  reducers: {},
  extraReducers: builder => {
    builder.addCase(fetchCandidates.fulfilled, (state, action) => {
      state.candidates = action.payload || []
    })
    builder.addCase(fetchCandidate.fulfilled, (state, action) => {
      state.candidate = action.payload || null
    })
    builder.addCase(fetchNotes.fulfilled, (state, action) => {
      state.notes = action.payload || []
    })
    builder.addCase(fetchDocuments.fulfilled, (state, action) => {
      state.documents = action.payload || []
    })
  }
})

export default appCandidatesSlice.reducer
