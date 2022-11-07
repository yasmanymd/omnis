// ** React Imports
import { useState } from 'react'
import { useRouter } from 'next/router'

// ** MUI Imports
import Box from '@mui/material/Box'
import { useTheme } from '@mui/material/styles'
import useMediaQuery from '@mui/material/useMediaQuery'

// ** Store & Actions Imports
import { useDispatch, useSelector } from 'react-redux'
import { sendMsg, selectCall, fetchUserProfile, fetchCallsContacts, removeSelectedCall } from 'src/store/apps/call'

// ** Hooks
import { useSettings } from 'src/@core/hooks/useSettings'

// ** Utils Imports
import { getInitials } from 'src/@core/utils/get-initials'
import { formatDateToMonthShort } from 'src/@core/utils/format'

// ** Call App Components Imports
import SidebarLeft from 'src/views/apps/call/SidebarLeft'
import CallContent from 'src/views/apps/call/CallContent'

// ** Layout Import
import BlankLayoutWithAppBar from 'src/@core/layouts/BlankLayoutWithAppBar'
import { ContextProvider } from '../../../layouts/context/SocketContext'

const AppCall = ({ meeting }) => {
  const router = useRouter();  
  if (!meeting) {
    router.push('/nomeeting');
  }

  // ** States
  const [userStatus, setUserStatus] = useState('online')
  const [leftSidebarOpen, setLeftSidebarOpen] = useState(false)
  const [userProfileLeftOpen, setUserProfileLeftOpen] = useState(false)
  const [userProfileRightOpen, setUserProfileRightOpen] = useState(false)

  // ** Hooks
  const theme = useTheme()
  const { settings } = useSettings()
  const dispatch = useDispatch()
  const hidden = useMediaQuery(theme.breakpoints.down('lg'))
  const store = useSelector(state => state.call)
  

  // ** Vars
  const smAbove = useMediaQuery(theme.breakpoints.up('sm'))
  const sidebarWidth = smAbove ? 370 : 300
  const mdAbove = useMediaQuery(theme.breakpoints.up('md'))
  const { skin, appBar, footer, layout, navHidden } = settings  

  const statusObj = {
    busy: 'error',
    away: 'warning',
    online: 'success',
    offline: 'secondary'
  };

  const handleLeftSidebarToggle = () => setLeftSidebarOpen(!leftSidebarOpen)
  const handleUserProfileLeftSidebarToggle = () => setUserProfileLeftOpen(!userProfileLeftOpen)
  const handleUserProfileRightSidebarToggle = () => setUserProfileRightOpen(!userProfileRightOpen)

  const calculateAppHeight = () => {
    return `(${
      (appBar === 'hidden' ? 0 : theme.mixins.toolbar.minHeight) * (layout === 'horizontal' && !navHidden ? 2 : 1) +
      (footer === 'hidden' ? 0 : 56)
    }px + ${theme.spacing(6)} * 2)`
  }

  return (
    <Box
      className='app-call'
      sx={{
        width: '100%',
        display: 'flex',
        borderRadius: 1,
        overflow: 'hidden',
        position: 'relative',
        backgroundColor: 'background.paper',
        boxShadow: skin === 'bordered' ? 0 : 6,
        height: `calc(100vh - ${calculateAppHeight()})`,
        ...(skin === 'bordered' && { border: `1px solid ${theme.palette.divider}` })
      }}
    >
      <SidebarLeft
        store={store}
        hidden={hidden}
        mdAbove={mdAbove}
        dispatch={dispatch}
        statusObj={statusObj}
        userStatus={userStatus}
        selectCall={selectCall}
        getInitials={getInitials}
        sidebarWidth={sidebarWidth}
        setUserStatus={setUserStatus}
        leftSidebarOpen={leftSidebarOpen}
        removeSelectedCall={removeSelectedCall}
        userProfileLeftOpen={userProfileLeftOpen}
        formatDateToMonthShort={formatDateToMonthShort}
        handleLeftSidebarToggle={handleLeftSidebarToggle}
        handleUserProfileLeftSidebarToggle={handleUserProfileLeftSidebarToggle}
      />
      <ContextProvider>
        <CallContent
          store={store}
          hidden={hidden}
          sendMsg={sendMsg}
          mdAbove={mdAbove}
          dispatch={dispatch}
          statusObj={statusObj}
          getInitials={getInitials}
          sidebarWidth={sidebarWidth}
          userProfileRightOpen={userProfileRightOpen}
          handleLeftSidebarToggle={handleLeftSidebarToggle}
          handleUserProfileRightSidebarToggle={handleUserProfileRightSidebarToggle}
        />
      </ContextProvider>
    </Box>
  )
}

AppCall.getLayout = page => <BlankLayoutWithAppBar>{page}</BlankLayoutWithAppBar>

export async function getServerSideProps({ params }) {
  if (params.code === '123-456-789') {
    return { 
      props: {
        meeting: {
          _id: '6368494effdbe51b2f394763',
          name: 'Test',
          code: '123-456-789',
          description: 'Test',
          participants: [
            'mariencita@gmail.com'
          ],
          start_time: 1667779200000,
          duration: 30,
          max_person: 4,
          status: 'created',
          created_at: 1667778894558,
          created_by: 'yasmany@gmail.com',
          __v: 0
        }
      } 
    };
  }

  return { props: {} }
}

AppCall.requireAuth = false;

export default AppCall;