import React, { useContext } from 'react';
import { useWebRTC } from '../../hooks/useWebRTC';
import Grid from '@mui/material/Grid';
import Card from '@mui/material/Card';
import CardActionArea from '@mui/material/CardActionArea';
import CardContent from '@mui/material/CardContent';
import Typography from '@mui/material/Typography';
import { width } from '@mui/system';

const VideoPlayer = props => {
  const { signalingServerUrl } = props;

  const {
    localStream,
    myVideo,
    videos
  } = useWebRTC(signalingServerUrl);

  return (
    <div ref={videos} style={{ width: '100%', height: '100%', display: 'flex', flexWrap: 'wrap' }}>
      <video playsInline ref={myVideo} autoPlay style={{ minHeight: '100%', maxHeight: '100%', minWidth: '100%', maxWidth: '100%', objectFit: 'cover' }} />
    </div>
    /*<Grid ref={videos} container columns={3} spacing={10} padding={10}>
      <Grid item xs={1}>
        <Card style={{ maxWidth: '100%', padding: 10 }}>
          <video playsInline ref={myVideo1} autoPlay style={{ width: '100%' }} />
        </Card>
      </Grid>
    </Grid>*/
  );
};

export default VideoPlayer;
