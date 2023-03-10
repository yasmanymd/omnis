// ** React Imports
import { useState, useCallback, useEffect, Fragment } from 'react'

// ** MUI Imports
import Card from '@mui/material/Card'
import Typography from '@mui/material/Typography'
import FormControl from '@mui/material/FormControl'
import FormHelperText from '@mui/material/FormHelperText';

// ** Demo Component Imports
import { Accordion, AccordionSummary, AccordionDetails, Grid, Button, Dialog, DialogTitle, DialogContent, DialogContentText, DialogActions, TextField, AccordionActions, IconButton } from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import EditIcon from '@mui/icons-material/Edit'

// ** Third Parties
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm, Controller } from 'react-hook-form';

// ** Store Imports
import { useDispatch } from 'react-redux'

// ** Actions Imports
import { createNote, updateNote, deleteNote } from 'src/store/apps/candidate'

const CandidateViewNotes = ({ notes, candidate_id }) => {
  const dispatch = useDispatch();
  const [openDialog, setOpenDialog] = useState(false);
  const [noteToEdit, setNoteToEdit] = useState(-1);

  // Handle Edit dialog
  const handleCreateClickOpen = () => setOpenDialog(true)
  const handleClose = () => {
    setNoteToEdit(-1)
    setOpenDialog(false)
  }
  const handleEditClickOpen = (index) => {
    setNoteToEdit(index)
    setOpenDialog(true)
  }

  const handleDelete = (index) => {
    const note = {
      _id: notes[index]._id,
      candidate_id: candidate_id
    };
    dispatch(deleteNote(note));
  }

  const schema = yup.object().shape({
    note: yup.string().required('Note is a required field.')
  }).required();

  const onSubmit = data => {
    const note = {
      note: data.note,
      candidate_id: candidate_id
    };
    if (noteToEdit == -1) {
      dispatch(createNote(note));
    } else {
      note._id = notes[noteToEdit]._id;
      dispatch(updateNote(note));
    }
    handleClose();
  }

  const {
    control,
    setValue,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: { note: '' }, resolver: yupResolver(schema) });

  const resetToStoredValues = useCallback(() => {
    if (noteToEdit == -1) {
      setValue('note', '');
    } else {
      setValue('note', notes[noteToEdit].note);
    }
  }, [setValue, noteToEdit]);

  useEffect(() => {
    resetToStoredValues();
  }, [openDialog, noteToEdit]);

  return (
    <Fragment>
      <Card>
        {notes.map((note, index) => (
          <Accordion>
            <AccordionSummary
              aria-controls="panel1a-content"
              id={index}
            >
              <div style={{ width: '100%', display: 'flex', justifyContent: 'space-between' }}>
                <Typography style={{ display: 'flex', alignItems: 'center' }} >Modified by {note.modified_by} on {new Date(note.modified_at).toLocaleDateString("en-US")} at {new Date(note.modified_at).toLocaleTimeString("en-US")}.</Typography>
                <div>
                  <IconButton aria-label="edit" onClick={(event) => {
                    handleEditClickOpen(index)
                    event.stopPropagation();
                  }}>
                    <EditIcon />
                  </IconButton>
                  <IconButton aria-label="delete" onClick={(event) => {
                    handleDelete(index)
                    event.stopPropagation();
                  }}>
                    <DeleteIcon />
                  </IconButton>
                </div>
              </div>
            </AccordionSummary>
            <AccordionDetails>
              <Typography style={{ whiteSpace: 'pre-wrap' }}>
                {note.note}
              </Typography>
            </AccordionDetails>
          </Accordion>
        ))}
      </Card>
      <Grid container sx={{ padding: 4 }}>
        <Button
          size='small'
          variant='contained'
          onClick={handleCreateClickOpen}
        >
          Add Note
        </Button>
        <Dialog
          open={openDialog}
          onClose={handleClose}
          aria-labelledby='user-view-edit'
          sx={{ '& .MuiPaper-root': { width: '100%', maxWidth: 650, p: [2, 10] } }}
          aria-describedby='user-view-edit-description'
        >
          <form onSubmit={handleSubmit(onSubmit)} noValidate autoComplete='off'>
            <DialogTitle id='user-view-edit' sx={{ textAlign: 'center', fontSize: '1.5rem !important' }}>
              {noteToEdit > -1 ? 'Edit Note' : 'Create Note'}
            </DialogTitle>
            <DialogContent>
              <DialogContentText variant='body2' id='user-view-edit-description' sx={{ textAlign: 'center', mb: 7 }}>
              </DialogContentText>
              <Grid container>
                <Grid fullWidth item style={{ width: '100%' }}>
                  <FormControl fullWidth>
                    <Controller
                      name='note'
                      control={control}
                      rules={{ required: true }}
                      render={({ field: { value, onChange } }) => (
                        <TextField multiline fullWidth minRows={10} maxRows={10} label='Note' value={value} onChange={onChange} error={Boolean(errors.note)} />
                      )}
                    />
                    {errors.note && (
                      <FormHelperText sx={{ color: 'error.main' }} id='event-note-error'>
                        {errors.note.message}
                      </FormHelperText>
                    )}
                  </FormControl>
                </Grid>
              </Grid>
            </DialogContent>
            <DialogActions sx={{ justifyContent: 'center' }}>
              <Button type='submit' variant='contained' sx={{ mr: 1 }}>
                Submit
              </Button>
              <Button variant='outlined' color='secondary' onClick={handleClose}>
                Cancel
              </Button>
            </DialogActions>
          </form>
        </Dialog>
      </Grid>
    </Fragment>
  )
}

export default CandidateViewNotes
