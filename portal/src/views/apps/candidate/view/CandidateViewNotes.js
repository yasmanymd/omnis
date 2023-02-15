// ** React Imports
import { useState, Fragment } from 'react'

// ** MUI Imports
import Card from '@mui/material/Card'
import Typography from '@mui/material/Typography'
import FormControl from '@mui/material/FormControl'
import FormHelperText from '@mui/material/FormHelperText';

// ** Demo Component Imports
import { Accordion, AccordionSummary, AccordionDetails, Grid, Button, Dialog, DialogTitle, DialogContent, DialogContentText, DialogActions, TextField } from '@mui/material'

// ** Third Parties
import * as yup from 'yup';
import { yupResolver } from '@hookform/resolvers/yup';
import { useForm, Controller } from 'react-hook-form';

// ** Store Imports
import { useDispatch } from 'react-redux'

// ** Actions Imports
import { createNote } from 'src/store/apps/candidate'

const CandidateViewNotes = ({ notes, candidate_id }) => {
  const dispatch = useDispatch();
  const [openCreate, setOpenCreate] = useState(false);

  // Handle Edit dialog
  const handleCreateClickOpen = () => setOpenCreate(true)
  const handleCreateClose = () => setOpenCreate(false)

  const schema = yup.object().shape({
    note: yup.string().required('Note is a required field.')
  }).required();

  const onSubmit = data => {
    const noteToCreate = {
      note: data.note,
      candidate_id: candidate_id
    };

    dispatch(createNote(noteToCreate));
    setOpenCreate(false);
  }

  const {
    control,
    setValue,
    handleSubmit,
    formState: { errors }
  } = useForm({ defaultValues: { note: '' }, resolver: yupResolver(schema) });

  return (
    <Fragment>
      <Card>
        {notes.map((note, index) => (
          <Accordion>
            <AccordionSummary
              aria-controls="panel1a-content"
              id={index}
            >
              <Typography>Created by {note.created_by} on {new Date(note.created_at).toLocaleDateString("en-US")} at {new Date(note.created_at).toLocaleTimeString("en-US")}.</Typography>
            </AccordionSummary>
            <AccordionDetails>
              <Typography>
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
          open={openCreate}
          onClose={handleCreateClose}
          aria-labelledby='user-view-edit'
          sx={{ '& .MuiPaper-root': { width: '100%', maxWidth: 650, p: [2, 10] } }}
          aria-describedby='user-view-edit-description'
        >
          <form onSubmit={handleSubmit(onSubmit)} noValidate autoComplete='off'>
            <DialogTitle id='user-view-edit' sx={{ textAlign: 'center', fontSize: '1.5rem !important' }}>
              Create Note
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
              <Button variant='outlined' color='secondary' onClick={handleCreateClose}>
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
