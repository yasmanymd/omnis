// ** MUI Imports
import Box from '@mui/material/Box'
import Card from '@mui/material/Card'
import Button from '@mui/material/Button'
import Avatar from '@mui/material/Avatar'
import CardMedia from '@mui/material/CardMedia'
import Typography from '@mui/material/Typography'
import CardContent from '@mui/material/CardContent'
import AvatarGroup from '@mui/material/AvatarGroup'
import VideoPlayer from '../../../../layouts/components/VideoPlayer'

const CardJoinMeeting = props => {
  const { signalingServerUrl } = props;

  return (
    <VideoPlayer signalingServerUrl={signalingServerUrl} />
  )
}

export default CardJoinMeeting
