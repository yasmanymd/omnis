// ** Toolkit imports
import { configureStore } from '@reduxjs/toolkit'

// ** Reducers
import call from 'src/store/apps/call'
import calendar from 'src/store/apps/calendar'

export const store = configureStore({
  reducer: {
    call, 
    calendar
  },
  middleware: getDefaultMiddleware =>
    getDefaultMiddleware({
      serializableCheck: false
    })
})
