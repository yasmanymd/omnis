// ** React Imports
import { useEffect } from 'react'

// ** MUI Imports
import Drawer from '@mui/material/Drawer'
import Button from '@mui/material/Button'
import { styled } from '@mui/material/styles'
import TextField from '@mui/material/TextField'
import Typography from '@mui/material/Typography'
import Box from '@mui/material/Box'
import FormControl from '@mui/material/FormControl'
import FormHelperText from '@mui/material/FormHelperText'

// ** Third Party Imports
import * as yup from 'yup'
import { yupResolver } from '@hookform/resolvers/yup'
import { useForm, Controller } from 'react-hook-form'

// ** Icons Imports
import Close from 'mdi-material-ui/Close'

// ** Store Imports
import { useDispatch } from 'react-redux'

// ** Actions Imports
import { createJob, fetchClients } from 'src/store/apps/job'
import { InputLabel, Select, OutlinedInput, MenuItem, Autocomplete, Chip } from '@mui/material'

const Header = styled(Box)(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  padding: theme.spacing(3, 4),
  justifyContent: 'space-between',
  backgroundColor: theme.palette.background.default
}))

const schema = yup.object().shape({
  title: yup.string().required(),
  description: yup.string().required(),
  client_id: yup.string().required()
})

const defaultValues = {
  title: '',
  description: '',
  client_id: '',
  tags: []
}

const SidebarAddJob = props => {
  // ** Props
  const { open, toggle, clients } = props

  // ** Hooks
  const dispatch = useDispatch()

  useEffect(() => {
    dispatch(fetchClients())
  }, []);

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
    dispatch(createJob(data))
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
        <Typography variant='h6'>Add Job</Typography>
        <Close fontSize='small' onClick={handleClose} sx={{ cursor: 'pointer' }} />
      </Header>
      <Box sx={{ p: 5 }}>
        <form onSubmit={handleSubmit(onSubmit)}>
          <FormControl fullWidth sx={{ mb: 6 }}>
            <Controller
              name='title'
              control={control}
              rules={{ required: true }}
              render={({ field: { value, onChange } }) => (
                <TextField
                  value={value}
                  label='Title'
                  onChange={onChange}
                  error={Boolean(errors.title)}
                />
              )}
            />
            {errors.title && <FormHelperText sx={{ color: 'error.main' }}>{errors.title.message}</FormHelperText>}
          </FormControl>
          <FormControl fullWidth sx={{ mb: 6 }}>
            <Controller
              name='description'
              control={control}
              rules={{ required: true }}
              render={({ field: { value, onChange } }) => (
                <TextField
                  multiline
                  minRows={4}
                  maxRows={4}
                  value={value}
                  label='Description'
                  onChange={onChange}
                  error={Boolean(errors.description)}
                />
              )}
            />
            {errors.description && <FormHelperText sx={{ color: 'error.main' }}>{errors.description.message}</FormHelperText>}
          </FormControl>
          <FormControl fullWidth sx={{ mb: 6 }}>
            <Controller
              name='tags'
              control={control}
              rules={{ required: false }}
              render={({ field: { ref, ...field } }) => (
                <Autocomplete
                  {...field}
                  multiple
                  id="tags-filled"
                  options={['Java', '.Net', 'Python', 'Golang', 'PHP', 'VB.Net', 'Ruby on Rails', 'Solidity', 'AEM', 'Elixir', 'Node', 'React Native', 'AWS', 'Azure', 'GCP', 'DevOps', 'SRE', 'QA Automation', 'QA Manual', 'Business Analyst', 'Functional Analyst', 'SysAdmin', 'Angular', 'React.js', 'Vue.js', 'Scrum Master', 'Project Manager', 'Consultant', 'Data Engineer', 'BI Architect', 'Cryptographer', 'Comunity Manager', 'Technical Support', 'iOS', 'Android', 'Flutter', 'CiberSecurity Analyst', 'BI Developer', 'BI Analyst', 'Architect']}
                  freeSolo
                  onChange={(event, value) => field.onChange(value)}
                  renderTags={(v, getTagProps) =>
                    v.map((option, index) => (
                      <Chip variant="outlined" label={option} color={Boolean(errors.tags) ? "error" : "default"} {...getTagProps({ index })} />
                    ))
                  }
                  renderInput={(params) => (
                    <TextField
                      {...params}
                      variant="outlined"
                      label="Tags"
                      inputRef={ref}
                      error={Boolean(errors.tags)}
                    />
                  )}
                />
              )}
            />
          </FormControl>
          <FormControl fullWidth sx={{ mb: 6 }}>
            <InputLabel id="client-label" error={Boolean(errors.client_id)}>Client</InputLabel>
            <Controller
              name="client_id"
              control={control}
              render={({ field: { value, onChange } }) => (
                <Select
                  value={value}
                  onChange={onChange}
                  labelId="client-label"
                  error={Boolean(errors.client_id)}
                  input={<OutlinedInput label="Client"
                    error={Boolean(errors.client_id)}
                  />}>
                  {clients.map((item) => (
                    <MenuItem key={item._id} value={item._id}>
                      {item.name}
                    </MenuItem>
                  ))}
                </Select>
              )}
            />
            {errors.client_id && (
              <FormHelperText sx={{ color: 'error.main' }} id='event-client_id-error'>
                {errors.client_id.message}
              </FormHelperText>
            )}
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

export default SidebarAddJob
