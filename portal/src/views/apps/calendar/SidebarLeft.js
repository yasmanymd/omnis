// ** MUI Imports
import Button from '@mui/material/Button';
import Drawer from '@mui/material/Drawer';

const SidebarLeft = props => {
  const {
    mdAbove,
    dispatch,
    leftSidebarOpen,
    leftSidebarWidth,
    handleSelectMeeting,
    handleLeftSidebarToggle,
    handleAddMeetingSidebarToggle
  } = props

  const handleSidebarToggleSidebar = () => {
    handleAddMeetingSidebarToggle()
    dispatch(handleSelectMeeting(null))
  }
  return (
    <Drawer
      open={leftSidebarOpen}
      onClose={handleLeftSidebarToggle}
      variant={mdAbove ? 'permanent' : 'temporary'}
      ModalProps={{
        disablePortal: true,
        disableAutoFocus: true,
        disableScrollLock: true,
        keepMounted: true // Better open performance on mobile.
      }}
      sx={{
        zIndex: 2,
        display: 'block',
        position: mdAbove ? 'static' : 'absolute',
        '& .MuiDrawer-paper': {
          borderRadius: 1,
          boxShadow: 'none',
          width: leftSidebarWidth,
          borderTopRightRadius: 0,
          borderBottomRightRadius: 0,
          p: theme => theme.spacing(5),
          zIndex: mdAbove ? '2' : 'drawer',
          position: mdAbove ? 'static' : 'absolute'
        },
        '& .MuiBackdrop-root': {
          borderRadius: 1,
          position: 'absolute'
        }
      }}
    >
      <Button variant='contained' onClick={handleSidebarToggleSidebar}>
        Add Meeting
      </Button>
    </Drawer>
  );
}

export default SidebarLeft
