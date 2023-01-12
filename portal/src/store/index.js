// ** Toolkit imports
import { configureStore } from '@reduxjs/toolkit'

// ** Reducers
import call from 'src/store/apps/call'
import calendar from 'src/store/apps/calendar'
import candidate from 'src/store/apps/candidate'

export const store = configureStore({
  reducer: {
    candidate,
    call,
    calendar
  },
  middleware: getDefaultMiddleware =>
    getDefaultMiddleware({
      serializableCheck: false
    })
})
