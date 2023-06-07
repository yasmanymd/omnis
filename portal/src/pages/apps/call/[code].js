// ** React Imports
import { useEffect, useState } from 'react'
import { useRouter } from 'next/router'

// ** MUI Imports
import Box from '@mui/material/Box'
import { useTheme } from '@mui/material/styles'
import useMediaQuery from '@mui/material/useMediaQuery'

// ** Store & Actions Imports
import { useDispatch, useSelector } from 'react-redux'
import { sendMsg, selectCall, fetchUserProfile, fetchCallsContacts, removeSelectedCall, fetchMeeting } from 'src/store/apps/call'

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

import getConfig from 'next/config';
import AppCallViewPage from 'src/views/apps/call/AppCallViewPage'

const { publicRuntimeConfig } = getConfig();

const AppCall = ({ code }) => {
  const store = useSelector(state => state.call);
  const dispatch = useDispatch();
  const router = useRouter();

  useEffect(() => {
    dispatch(fetchMeeting(code));
  }, [code]);

  if (store?.currentCall) {
    if (store?.currentCall?.length == 0) {
      router.push('/nomeeting');
    }
    if (store?.currentCall?.length == 1) {
      return <AppCallViewPage />
    }
  }

  return null
}

AppCall.getLayout = page => <BlankLayoutWithAppBar>{page}</BlankLayoutWithAppBar>

export async function getServerSideProps({ params }) {
  return {
    props: {
      code: params?.code
    }
  };
}

export default AppCall;