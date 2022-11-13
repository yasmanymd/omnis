// ** React Imports
import { useState, Fragment } from 'react'

// ** MUI Imports
import Menu from '@mui/material/Menu'
import Badge from '@mui/material/Badge'
import MuiAvatar from '@mui/material/Avatar'
import Avatar from '@mui/material/Avatar'
import MenuItem from '@mui/material/MenuItem'
import { styled } from '@mui/material/styles'
import Typography from '@mui/material/Typography'
import IconButton from '@mui/material/IconButton'
import VideocamIcon from '@mui/icons-material/Videocam';
import Box from '@mui/material/Box'
import Stack from '@mui/material/Stack'

// ** Icons Imports
import MenuIcon from 'mdi-material-ui/Menu'
import Magnify from 'mdi-material-ui/Magnify'
import PhoneOutline from 'mdi-material-ui/PhoneOutline'
import VideoOutline from 'mdi-material-ui/VideoOutline'
import DotsVertical from 'mdi-material-ui/DotsVertical'
import MessageOutline from 'mdi-material-ui/MessageOutline'

// ** Custom Components Import
import CallLog from './CallLog'
import SendMsgForm from 'src/views/apps/call/SendMsgForm'
import CustomAvatar from 'src/@core/components/mui/avatar'
import UserProfileRight from 'src/views/apps/call/UserProfileRight'
import CardJoinMeeting from '../../ui/cards/video/CardJoinMeeting'

// ** Styled Components
const CallWrapperStartCall = styled(Box)(({ theme }) => ({
  flexGrow: 1,
  height: '100%',
  display: 'flex',
  borderRadius: 1,
  alignItems: 'center',
  flexDirection: 'column',
  justifyContent: 'center',
  backgroundColor: theme.palette.action.hover
}))

const CallContent = props => {
  // ** Props
  const {
    store,
    hidden,
    sendMsg,
    mdAbove,
    dispatch,
    statusObj,
    getInitials,
    sidebarWidth,
    userProfileRightOpen,
    handleLeftSidebarToggle,
    handleUserProfileRightSidebarToggle,
    signalingServerUrl
  } = props

  // ** State
  const [anchorEl, setAnchorEl] = useState(null)
  const open = Boolean(anchorEl)

  const handleClick = event => {
    setAnchorEl(event.currentTarget)
  }

  const handleClose = () => {
    setAnchorEl(null)
  }

  const handleJoinMeeting = () => {
    if (!mdAbove) {
      handleLeftSidebarToggle()
    }
  }

  const renderContent = () => {
    if (store) {
      const selectedCall = store.selectedCall
      if (!selectedCall) {
        return (
          <CardJoinMeeting signalingServerUrl={signalingServerUrl} />
        )
      } else {
        return (
          <Box
            sx={{
              flexGrow: 1,
              width: '100%',
              height: '100%',
              backgroundColor: theme => theme.palette.action.hover
            }}
          >
            <Box
              sx={{
                py: 3,
                px: 5,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                borderBottom: theme => `1px solid ${theme.palette.divider}`
              }}
            >
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                {mdAbove ? null : (
                  <IconButton onClick={handleLeftSidebarToggle} sx={{ mr: 2 }}>
                    <MenuIcon />
                  </IconButton>
                )}
                <Box
                  onClick={handleUserProfileRightSidebarToggle}
                  sx={{ display: 'flex', alignItems: 'center', cursor: 'pointer' }}
                >
                  <Badge
                    overlap='circular'
                    anchorOrigin={{
                      vertical: 'bottom',
                      horizontal: 'right'
                    }}
                    sx={{ mr: 3 }}
                    badgeContent={
                      <Box
                        component='span'
                        sx={{
                          width: 8,
                          height: 8,
                          borderRadius: '50%',
                          color: `${statusObj[selectedCall.contact.status]}.main`,
                          boxShadow: theme => `0 0 0 2px ${theme.palette.background.paper}`,
                          backgroundColor: `${statusObj[selectedCall.contact.status]}.main`
                        }}
                      />
                    }
                  >
                    {selectedCall.contact.avatar ? (
                      <MuiAvatar
                        src={selectedCall.contact.avatar}
                        alt={selectedCall.contact.fullName}
                        sx={{ width: '2.375rem', height: '2.375rem' }}
                      />
                    ) : (
                      <CustomAvatar
                        skin='light'
                        color={selectedCall.contact.avatarColor}
                        sx={{ width: '2.375rem', height: '2.375rem', fontSize: '1rem' }}
                      >
                        {getInitials(selectedCall.contact.fullName)}
                      </CustomAvatar>
                    )}
                  </Badge>
                  <Box sx={{ display: 'flex', flexDirection: 'column' }}>
                    <Typography sx={{ fontWeight: 500, fontSize: '0.875rem' }}>
                      {selectedCall.contact.fullName}
                    </Typography>
                    <Typography variant='caption' sx={{ color: 'text.disabled' }}>
                      {selectedCall.contact.role}
                    </Typography>
                  </Box>
                </Box>
              </Box>

              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                {mdAbove ? (
                  <Fragment>
                    <IconButton size='small' sx={{ color: 'text.secondary' }}>
                      <PhoneOutline sx={{ fontSize: '1.25rem' }} />
                    </IconButton>
                    <IconButton size='small' sx={{ color: 'text.secondary' }}>
                      <VideoOutline sx={{ fontSize: '1.5rem' }} />
                    </IconButton>
                    <IconButton size='small' sx={{ color: 'text.secondary' }}>
                      <Magnify sx={{ fontSize: '1.25rem' }} />
                    </IconButton>
                  </Fragment>
                ) : null}
                <IconButton size='small' onClick={handleClick} sx={{ color: 'text.secondary' }}>
                  <DotsVertical sx={{ fontSize: '1.25rem' }} />
                </IconButton>
                <Menu
                  open={open}
                  sx={{ mt: 2 }}
                  anchorEl={anchorEl}
                  onClose={handleClose}
                  anchorOrigin={{
                    vertical: 'bottom',
                    horizontal: 'right'
                  }}
                  transformOrigin={{
                    vertical: 'top',
                    horizontal: 'right'
                  }}
                >
                  <MenuItem onClick={handleClose}>View Contact</MenuItem>
                  <MenuItem onClick={handleClose}>Mute Notifications</MenuItem>
                  <MenuItem onClick={handleClose}>Block Contact</MenuItem>
                  <MenuItem onClick={handleClose}>Clear Call</MenuItem>
                  <MenuItem onClick={handleClose}>Report</MenuItem>
                </Menu>
              </Box>
            </Box>

            {selectedCall && store.userProfile ? (
              <CallLog hidden={hidden} data={{ ...selectedCall, userContact: store.userProfile }} />
            ) : null}

            <SendMsgForm store={store} dispatch={dispatch} sendMsg={sendMsg} />

            <UserProfileRight
              store={store}
              hidden={hidden}
              statusObj={statusObj}
              getInitials={getInitials}
              sidebarWidth={sidebarWidth}
              userProfileRightOpen={userProfileRightOpen}
              handleUserProfileRightSidebarToggle={handleUserProfileRightSidebarToggle}
            />
          </Box>
        )
      }
    } else {
      return null
    }
  }

  return renderContent()
}

export default CallContent;
