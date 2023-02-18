// ** Toolkit imports
import { configureStore } from '@reduxjs/toolkit'

// ** Reducers
import call from 'src/store/apps/call'
import calendar from 'src/store/apps/calendar'
import candidate from 'src/store/apps/candidate'
import client from 'src/store/apps/client'
import job from 'src/store/apps/job'

export const store = configureStore({
  reducer: {
    candidate,
    client,
    job,
    call,
    calendar
  },
  middleware: getDefaultMiddleware =>
    getDefaultMiddleware({
      serializableCheck: false
    })
})
