import React, { useContext } from 'react';

import { SocketContext } from '../../layouts/context/SocketContext';

const VideoPlayer = () => {
  const { myVideo, stream } = useContext(SocketContext);
  
  return (
    <div>
      {stream && (
        <video playsInline ref={myVideo} autoPlay />
      )}
    </div>
  );
};

export default VideoPlayer;
