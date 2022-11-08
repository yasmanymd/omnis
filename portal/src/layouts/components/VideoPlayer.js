import React, { useContext } from 'react';
import { useWebRTC } from '../../hooks/useWebRTC';

const VideoPlayer = props => {
  const { signalingServerUrl } = props;

  const {
    name,
    setName,
    userVideo,
    myVideo,
    callAccepted,
    callPeer,
    stream,
    acceptCall,
    me,
    receivingCall,
    caller,
    sendMessage,
    messages,
    rejectCall,
    calling,
    cancelCall,
    endCall,
  } = useWebRTC(signalingServerUrl);
  
  return (
    <div>
      {stream && (
        <video playsInline ref={myVideo} autoPlay />
      )}
    </div>
  );
};

export default VideoPlayer;
