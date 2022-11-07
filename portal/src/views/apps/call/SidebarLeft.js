// ** React Imports
import { useState, useEffect } from 'react'

// ** Next Imports
import { useRouter } from 'next/router'

// ** MUI Imports
import Box from '@mui/material/Box'
import List from '@mui/material/List'
import Chip from '@mui/material/Chip'
import Badge from '@mui/material/Badge'
import Drawer from '@mui/material/Drawer'
import MuiAvatar from '@mui/material/Avatar'
import ListItem from '@mui/material/ListItem'
import TextField from '@mui/material/TextField'
import IconButton from '@mui/material/IconButton'
import Typography from '@mui/material/Typography'
import ListItemText from '@mui/material/ListItemText'
import ListItemAvatar from '@mui/material/ListItemAvatar'
import ListItemButton from '@mui/material/ListItemButton'
import InputAdornment from '@mui/material/InputAdornment'

// ** Third Party Components
import PerfectScrollbar from 'react-perfect-scrollbar'

// ** Icons Imports
import Close from 'mdi-material-ui/Close'
import Magnify from 'mdi-material-ui/Magnify'

// ** Custom Components Import
import CustomAvatar from 'src/@core/components/mui/avatar'

// ** Call App Components Imports
import UserProfileLeft from 'src/views/apps/call/UserProfileLeft'

const ScrollWrapper = ({ children, hidden }) => {
  if (hidden) {
    return <Box sx={{ height: '100%', overflow: 'auto' }}>{children}</Box>
  } else {
    return <PerfectScrollbar options={{ wheelPropagation: false }}>{children}</PerfectScrollbar>
  }
}

const SidebarLeft = props => {
  // ** Props
  const {
    store,
    hidden,
    mdAbove,
    dispatch,
    statusObj,
    userStatus,
    selectCall,
    getInitials,
    sidebarWidth,
    setUserStatus,
    leftSidebarOpen,
    removeSelectedCall,
    userProfileLeftOpen,
    formatDateToMonthShort,
    handleLeftSidebarToggle,
    handleUserProfileLeftSidebarToggle
  } = props

  // ** States
  const [query, setQuery] = useState('')
  const [filteredCall, setFilteredCall] = useState([])
  const [filteredContacts, setFilteredContacts] = useState([])
  const [active, setActive] = useState(null)

  // ** Hooks
  const router = useRouter()

  const handleCallClick = (type, id) => {
    dispatch(selectCall(id))
    setActive({ type, id })
    if (!mdAbove) {
      handleLeftSidebarToggle()
    }
  }
  useEffect(() => {
    if (store && store.calls) {
      if (active !== null) {
        if (active.type === 'contact' && active.id === store.calls[0].id) {
          setActive({ type: 'call', id: active.id })
        }
      }
    }
  }, [store, active])
  useEffect(() => {
    router.events.on('routeChangeComplete', () => {
      setActive(null)
      dispatch(removeSelectedCall())
    })

    return () => {
      setActive(null)
      dispatch(removeSelectedCall())
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  const hasActiveId = id => {
    if (store.calls !== null) {
      const arr = store.calls.filter(i => i.id === id)

      return !!arr.length
    }
  }

  const renderCalls = () => {
    if (store && store.calls && store.calls.length) {
      if (query.length && !filteredCall.length) {
        return (
          <ListItem>
            <Typography sx={{ color: 'text.secondary' }}>No Calls Found</Typography>
          </ListItem>
        )
      } else {
        const arrToMap = query.length && filteredCall.length ? filteredCall : store.calls

        return arrToMap.map((call, index) => {
          const { lastMessage } = call.call
          const activeCondition = active !== null && active.id === call.id && active.type === 'call'

          return (
            <ListItem key={index} disablePadding sx={{ '&:not(:last-child)': { mb: 1.5 } }}>
              <ListItemButton
                disableRipple
                onClick={() => handleCallClick('call', call.id)}
                sx={{
                  px: 3,
                  py: 2.5,
                  width: '100%',
                  borderRadius: 1,
                  alignItems: 'flex-start',
                  ...(activeCondition && {
                    backgroundImage: theme =>
                      `linear-gradient(98deg, ${theme.palette.customColors.primaryGradient}, ${theme.palette.primary.main} 94%)`
                  })
                }}
              >
                <ListItemAvatar sx={{ m: 0 }}>
                  <Badge
                    overlap='circular'
                    anchorOrigin={{
                      vertical: 'bottom',
                      horizontal: 'right'
                    }}
                    badgeContent={
                      <Box
                        component='span'
                        sx={{
                          width: 8,
                          height: 8,
                          borderRadius: '50%',
                          color: `${statusObj[call.status]}.main`,
                          backgroundColor: `${statusObj[call.status]}.main`,
                          boxShadow: theme =>
                            `0 0 0 2px ${
                              !activeCondition ? theme.palette.background.paper : theme.palette.common.white
                            }`
                        }}
                      />
                    }
                  >
                    {call.avatar ? (
                      <MuiAvatar
                        src={call.avatar}
                        alt={call.fullName}
                        sx={{
                          width: 38,
                          height: 38,
                          border: theme => (activeCondition ? `2px solid ${theme.palette.common.white}` : '')
                        }}
                      />
                    ) : (
                      <CustomAvatar
                        color={call.avatarColor}
                        skin={activeCondition ? 'light-static' : 'light'}
                        sx={{
                          width: 38,
                          height: 38,
                          fontSize: '1rem',
                          border: theme => (activeCondition ? `2px solid ${theme.palette.common.white}` : '')
                        }}
                      >
                        {getInitials(call.fullName)}
                      </CustomAvatar>
                    )}
                  </Badge>
                </ListItemAvatar>
                <ListItemText
                  sx={{
                    my: 0,
                    ml: 4,
                    mr: 1.5,
                    '& .MuiTypography-root': { ...(activeCondition ? { color: 'common.white' } : {}) }
                  }}
                  primary={
                    <Typography noWrap sx={{ fontWeight: 500, fontSize: '0.875rem' }}>
                      {call.fullName}
                    </Typography>
                  }
                  secondary={
                    <Typography
                      noWrap
                      variant='body2'
                      sx={{ color: !activeCondition ? theme => theme.palette.text.disabled : {} }}
                    >
                      {lastMessage ? lastMessage.message : null}
                    </Typography>
                  }
                />
                <Box
                  sx={{
                    display: 'flex',
                    alignItems: 'flex-end',
                    flexDirection: 'column',
                    justifyContent: 'flex-start'
                  }}
                >
                  <Typography
                    variant='body2'
                    sx={{ whiteSpace: 'nowrap', color: activeCondition ? 'common.white' : 'text.disabled' }}
                  >
                    <>{lastMessage ? formatDateToMonthShort(lastMessage.time, true) : new Date()}</>
                  </Typography>
                  {call.call.unseenMsgs && call.call.unseenMsgs > 0 ? (
                    <Chip
                      color='error'
                      label={call.call.unseenMsgs}
                      sx={{
                        mt: 0.5,
                        height: 18,
                        fontWeight: 600,
                        fontSize: '0.75rem',
                        '& .MuiChip-label': { pt: 0.25, px: 1.655 }
                      }}
                    />
                  ) : null}
                </Box>
              </ListItemButton>
            </ListItem>
          )
        })
      }
    }
  }

  const renderContacts = () => {
    if (store && store.calls && store.calls.length) {
      if (query.length && !filteredContacts.length) {
        return (
          <ListItem>
            <Typography sx={{ color: 'text.secondary' }}>No Contacts Found</Typography>
          </ListItem>
        )
      } else {
        const arrToMap = query.length && filteredContacts.length ? filteredContacts : store.contacts

        return arrToMap !== null
          ? arrToMap.map((contact, index) => {
              const activeCondition =
                active !== null && active.id === contact.id && active.type === 'contact' && !hasActiveId(contact.id)

              return (
                <ListItem key={index} disablePadding sx={{ '&:not(:last-child)': { mb: 1.5 } }}>
                  <ListItemButton
                    disableRipple
                    onClick={() => handleCallClick(hasActiveId(contact.id) ? 'call' : 'contact', contact.id)}
                    sx={{
                      px: 3,
                      py: 2.5,
                      width: '100%',
                      borderRadius: 1,
                      ...(activeCondition && {
                        backgroundImage: theme =>
                          `linear-gradient(98deg, ${theme.palette.customColors.primaryGradient}, ${theme.palette.primary.main} 94%)`
                      })
                    }}
                  >
                    <ListItemAvatar sx={{ m: 0 }}>
                      {contact.avatar ? (
                        <MuiAvatar
                          alt={contact.fullName}
                          src={contact.avatar}
                          sx={{
                            width: 38,
                            height: 38,
                            border: theme => (activeCondition ? `2px solid ${theme.palette.common.white}` : '')
                          }}
                        />
                      ) : (
                        <CustomAvatar
                          color={contact.avatarColor}
                          skin={activeCondition ? 'light-static' : 'light'}
                          sx={{
                            width: 38,
                            height: 38,
                            fontSize: '1rem',
                            border: theme => (activeCondition ? `2px solid ${theme.palette.common.white}` : '')
                          }}
                        >
                          {getInitials(contact.fullName)}
                        </CustomAvatar>
                      )}
                    </ListItemAvatar>
                    <ListItemText
                      sx={{ my: 0, ml: 4, '& .MuiTypography-root': { color: activeCondition ? 'common.white' : '' } }}
                      primary={
                        <Typography sx={{ fontWeight: 500, fontSize: '0.875rem' }}>{contact.fullName}</Typography>
                      }
                      secondary={
                        <Typography
                          noWrap
                          variant='body2'
                          sx={{ color: !activeCondition ? theme => theme.palette.text.disabled : {} }}
                        >
                          {contact.about}
                        </Typography>
                      }
                    />
                  </ListItemButton>
                </ListItem>
              )
            })
          : null
      }
    }
  }

  const handleFilter = e => {
    setQuery(e.target.value)
    if (store.calls !== null && store.contacts !== null) {
      const searchFilterFunction = contact => contact.fullName.toLowerCase().includes(e.target.value.toLowerCase())
      const filteredCallsArr = store.calls.filter(searchFilterFunction)
      const filteredContactsArr = store.contacts.filter(searchFilterFunction)
      setFilteredCall(filteredCallsArr)
      setFilteredContacts(filteredContactsArr)
    }
  }

  return (
    <Box>
      <Drawer
        open={leftSidebarOpen}
        onClose={handleLeftSidebarToggle}
        variant={mdAbove ? 'permanent' : 'temporary'}
        ModalProps={{
          disablePortal: true,
          keepMounted: true // Better open performance on mobile.
        }}
        sx={{
          zIndex: 7,
          height: '100%',
          display: 'block',
          position: mdAbove ? 'static' : 'absolute',
          '& .MuiDrawer-paper': {
            boxShadow: 'none',
            width: sidebarWidth,
            position: mdAbove ? 'static' : 'absolute',
            borderTopLeftRadius: theme => theme.shape.borderRadius,
            borderBottomLeftRadius: theme => theme.shape.borderRadius
          },
          '& > .MuiBackdrop-root': {
            borderRadius: 1,
            position: 'absolute',
            zIndex: theme => theme.zIndex.drawer - 1
          }
        }}
      >
        <Box
          sx={{
            py: 3,
            px: 5,
            display: 'flex',
            alignItems: 'center',
            borderBottom: theme => `1px solid ${theme.palette.divider}`
          }}
        >
          {store && store.userProfile ? (
            <Badge
              overlap='circular'
              anchorOrigin={{
                vertical: 'bottom',
                horizontal: 'right'
              }}
              sx={{ mr: 4 }}
              onClick={handleUserProfileLeftSidebarToggle}
              badgeContent={
                <Box
                  component='span'
                  sx={{
                    width: 8,
                    height: 8,
                    borderRadius: '50%',
                    color: `${statusObj[userStatus]}.main`,
                    backgroundColor: `${statusObj[userStatus]}.main`,
                    boxShadow: theme => `0 0 0 2px ${theme.palette.background.paper}`
                  }}
                />
              }
            >
              <MuiAvatar
                src={store.userProfile.avatar}
                alt={store.userProfile.fullName}
                sx={{ width: '2.375rem', height: '2.375rem', cursor: 'pointer' }}
              />
            </Badge>
          ) : null}
          <TextField
            fullWidth
            size='small'
            value={query}
            onChange={handleFilter}
            placeholder='Search for contact...'
            sx={{ '& .MuiInputBase-root': { borderRadius: 5 } }}
            InputProps={{
              startAdornment: (
                <InputAdornment position='start' sx={{ color: 'text.secondary' }}>
                  <Magnify fontSize='small' />
                </InputAdornment>
              )
            }}
          />
          {!mdAbove ? (
            <IconButton sx={{ p: 1, ml: 1 }} onClick={handleLeftSidebarToggle}>
              <Close sx={{ fontSize: '1.375rem' }} />
            </IconButton>
          ) : null}
        </Box>

        <Box sx={{ height: `calc(100% - 4.0625rem)` }}>
          <ScrollWrapper hidden={hidden}>
            <Box sx={{ p: theme => theme.spacing(7, 3, 3) }}>
              <Typography variant='h6' sx={{ ml: 3, mb: 3, color: 'primary.main' }}>
                Calls
              </Typography>
              <List sx={{ mb: 4, p: 0 }}>{renderCalls()}</List>
              <Typography variant='h6' sx={{ ml: 3, mb: 3, color: 'primary.main' }}>
                Contacts
              </Typography>
              <List sx={{ p: 0 }}>{renderContacts()}</List>
            </Box>
          </ScrollWrapper>
        </Box>
      </Drawer>

      <UserProfileLeft
        store={store}
        hidden={hidden}
        statusObj={statusObj}
        userStatus={userStatus}
        sidebarWidth={sidebarWidth}
        setUserStatus={setUserStatus}
        userProfileLeftOpen={userProfileLeftOpen}
        handleUserProfileLeftSidebarToggle={handleUserProfileLeftSidebarToggle}
      />
    </Box>
  )
}

export default SidebarLeft;