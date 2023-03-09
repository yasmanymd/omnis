// ** Icon imports
import HomeOutline from 'mdi-material-ui/HomeOutline'
import EmailOutline from 'mdi-material-ui/EmailOutline'
import ShieldOutline from 'mdi-material-ui/ShieldOutline'
import CalendarBlankOutline from 'mdi-material-ui/CalendarBlankOutline'
import AccountGroup from 'mdi-material-ui/AccountGroup'
import TextBoxMultipleOutline from 'mdi-material-ui/TextBoxMultipleOutline'
import BulletinBoard from 'mdi-material-ui/BulletinBoard'
import OfficeBuilding from 'mdi-material-ui/OfficeBuilding'

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
      icon: AccountGroup,
      path: '/apps/candidate/list'
    },
    {
      title: 'Clients',
      icon: OfficeBuilding,
      path: '/apps/client/list'
    },
    {
      title: 'Jobs',
      icon: TextBoxMultipleOutline,
      path: '/apps/job/list'
    },
    {
      title: 'Board',
      icon: BulletinBoard,
      path: '/apps/board'
    }
  ]
}

export default navigation
