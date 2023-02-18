// ** Icon imports
import HomeOutline from 'mdi-material-ui/HomeOutline'
import EmailOutline from 'mdi-material-ui/EmailOutline'
import ShieldOutline from 'mdi-material-ui/ShieldOutline'
import CalendarBlankOutline from 'mdi-material-ui/CalendarBlankOutline'

const navigation = () => {
  return [
    {
      title: 'Home',
      icon: HomeOutline,
      path: '/home'
    },
    {
      title: 'Second Page',
      icon: EmailOutline,
      path: '/second-page'
    },
    {
      title: 'Access Control',
      icon: ShieldOutline,
      path: '/acl',
      action: 'read',
      subject: 'acl-page'
    },
    {
      sectionTitle: 'Apps'
    },
    {
      title: 'Calendar',
      icon: CalendarBlankOutline,
      path: '/apps/calendar'
    },
    {
      title: 'Candidates',
      icon: CalendarBlankOutline,
      path: '/apps/candidate/list'
    },
    {
      title: 'Clients',
      icon: CalendarBlankOutline,
      path: '/apps/client/list'
    },
    {
      title: 'Jobs',
      icon: CalendarBlankOutline,
      path: '/apps/job/list'
    }
  ]
}

export default navigation
