// ** React Imports

// ** MUI Imports
import Drawer from '@mui/material/Drawer'
import Button from '@mui/material/Button'
import { styled } from '@mui/material/styles'
import TextField from '@mui/material/TextField'
import Typography from '@mui/material/Typography'
import Box from '@mui/material/Box'
import FormControl from '@mui/material/FormControl'

// ** Third Party Imports
import * as yup from 'yup'
import { yupResolver } from '@hookform/resolvers/yup'
import { useForm, Controller } from 'react-hook-form'

// ** Icons Imports
import Close from 'mdi-material-ui/Close'

// ** Store Imports
import { useDispatch } from 'react-redux'

// ** Actions Imports
import MuiAutocomplete from '@mui/material/Autocomplete'
import { assignCandidatesToJob } from 'src/store/apps/job'

const Header = styled(Box)(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(3, 4),
  justifyContent: 'space-between',
  backgroundColor: theme.palette.background.default
}))

const schema = yup.object().shape({
  item: yup.object().required("Job is a required field")
})

const defaultValues = {
  item: null
}

const AssignToJobDrawer = props => {
  // ** Props
  const { open, toggle, jobs, selectionCandidates } = props

  // ** Hooks
  const dispatch = useDispatch()

  const {
    reset,
    control,
    handleSubmit,
    formState: { errors }
  } = useForm({
    defaultValues,
    mode: 'onChange',
    resolver: yupResolver(schema)
  })

  const onSubmit = data => {
    dispatch(assignCandidatesToJob({ candidates: selectionCandidates, job: data.item._id }))
    toggle()
    reset()
  }

  const handleClose = () => {
    toggle()
    reset()
  }

  return (
    <Drawer
      open={open}
      anchor='right'
      variant='temporary'
      onClose={handleClose}
      ModalProps={{ keepMounted: true }}
      sx={{ '& .MuiDrawer-paper': { width: { xs: 300, sm: 400 } } }}
    >
      <Header>
        <Typography variant='h6'>Assign To Job</Typography>
        <Close fontSize='small' onClick={handleClose} sx={{ cursor: 'pointer' }} />
      </Header>
      <Box sx={{ p: 5 }}>
        <form onSubmit={handleSubmit(onSubmit)} noValidate>
          <FormControl fullWidth sx={{ mb: 6 }}>
            <Controller
              control={control}
              name="item"
              rules={{ required: true }}
              render={({ field: { onChange, value } }) => (
                <MuiAutocomplete
                  onChange={(event, item) => {
                    onChange(item);
                  }}
                  value={value}
                  options={jobs}
                  getOptionLabel={(item) => (item.title ? item.title : "")}
                  getOptionSelected={(option, value) =>
                    value === undefined || value === "" || option._id === value._id
                  }
                  renderInput={(params) => (
                    <TextField
                      {...params}
                      label="Jobs"
                      margin="normal"
                      variant="outlined"
                      error={!!errors.item}
                      helperText={errors.item && "item required"}

                    />
                  )}
                />
              )}
            />
          </FormControl>
          <Box sx={{ display: 'flex', alignItems: 'center' }}>
            <Button size='large' type='submit' variant='contained' sx={{ mr: 3 }}>
              Submit
            </Button>
            <Button size='large' variant='outlined' color='secondary' onClick={handleClose}>
              Cancel
            </Button>
          </Box>
        </form>
      </Box>
    </Drawer>
  )
}

export default AssignToJobDrawer
