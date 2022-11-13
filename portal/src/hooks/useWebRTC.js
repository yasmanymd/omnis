import { useEffect, useRef, useState } from "react";

import io from "socket.io-client";
import Peer from "simple-peer";

import { useRouter } from "next/dist/client/router";
import toast from 'react-hot-toast';
import ErrorDetails from '../layouts/components/ErrorDetails';
import SimplePeer from "simple-peer";
//import { useMediaQuery } from "@material-ui/core";
//import { MyTheme } from "./theme";

const ab2str = (buf) => {
  return new TextDecoder().decode(buf);
}

export const useWebRTC = (signalingServerUrl) => {
  const socket = useRef(null);
  const peers = useRef({});
  const videos = useRef();
  const localStream = useRef();
  const myVideo = useRef();
  const configuration = {
    // Using From https://www.metered.ca/tools/openrelay/
    "iceServers": [
      {
        urls: "stun:openrelay.metered.ca:80"
      },
      {
        urls: "turn:openrelay.metered.ca:80",
        username: "openrelayproject",
        credential: "openrelayproject"
      },
      {
        urls: "turn:openrelay.metered.ca:443",
        username: "openrelayproject",
        credential: "openrelayproject"
      },
      {
        urls: "turn:openrelay.metered.ca:443?transport=tcp",
        username: "openrelayproject",
        credential: "openrelayproject"
      }
    ]
  };
  /*const router = useRouter();
  const [name, setName] = useState("");
  const [me, setMe] = useState("");
  
  const [receivingCall, setReceivingCall] = useState(false);
  const [calling, setCalling] = useState(false);
  const [callReciever, setCallReciever] = useState(false);
  const [caller, setCaller] = useState(null);
  const [callerSignal, setCallerSignal] = useState(null);
  const [callAccepted, setCallAccepted] = useState(false);

  //const mobile = useMediaQuery((theme: MyTheme) => theme.breakpoints.down('sm'))
 

  const [callCancelled, setCallCancelled] = useState(false);

  const [messages, setMessages] = useState([]);
  
  const userVideo = useRef(null);

  const callerPeer = useRef(null);
  const answerPeer = useRef(null);

  const messageSound = useRef(null);
  const callSound = useRef(null);
  const recieveCallSound = useRef(null);*/

  useEffect(() => {
    navigator.mediaDevices
      .getUserMedia({
        video: true,
        audio: false,
      })
      .then((stream) => {
        myVideo.current.srcObject = stream;
        localStream.current = stream;
        init();
      })
      .catch(error => {
        toast.error(<ErrorDetails message='Error accessing media devices.' errors={{ 'details': { message: error.message } }} />);
      });
  }, []);

  const init = () => {
    socket.current = io(signalingServerUrl);

    socket.current.on('initReceive', socket_id => {
      console.log('INIT RECEIVE ' + socket_id);
      addPeer(socket_id, false);

      socket.current.emit('initSend', { init_socket_id: socket_id });
    })

    socket.current.on('initSend', ({ init_socket_id: socket_id }) => {
      console.log('INIT SEND ' + socket_id);
      addPeer(socket_id, true);
    })

    socket.current.on('removePeer', socket_id => {
      console.log('removing peer ' + socket_id);
      removePeer(socket_id);
    })

    socket.current.on('disconnect', () => {
      console.log('GOT DISCONNECTED')
      for (let socket_id in peers) {
        removePeer(socket_id)
      }
    });

    socket.current.on('signal', data => {
      peers[data.socket_id].signal(data.signal);
    })
  }

  const resize = (videos) => {
    const mh = [0, 100, 100, 100, 50, 50, 50, 50, 50, 33, 33, 33, 33, 25, 25, 25, 25];
    const mw = [0, 100, 50, 33, 50, 33, 33, 25, 25, 33, 25, 25, 25, 25, 25, 25, 25];
    const pos = videos.children.length;
    for (let idx in peers) {
      let elem = document.getElementById(idx);
      if (elem) {
        elem.style.minHeight = mh[pos] + '%';
        elem.style.maxHeight = mh[pos] + '%';
        elem.style.minWidth = mw[pos] + '%';
        elem.style.maxWidth = mw[pos] + '%';
        elem.style.objectFit = 'cover';
      }
    }
    myVideo.current.style.minHeight = mh[pos] + '%';
    myVideo.current.style.maxHeight = mh[pos] + '%';
    myVideo.current.style.minWidth = mw[pos] + '%';
    myVideo.current.style.maxWidth = mw[pos] + '%';
    myVideo.current.style.objectFit = 'cover';
  }

  const addPeer = (socket_id, am_initiator) => {
    peers[socket_id] = new SimplePeer({
      initiator: am_initiator,
      stream: localStream.current,
      config: configuration
    });

    peers[socket_id].on('signal', data => {
      socket.current.emit('signal', {
        signal: data,
        socket_id: socket_id
      })
    });

    peers[socket_id].on('stream', stream => {
      let newVid = document.createElement('video');
      newVid.srcObject = stream;
      newVid.id = socket_id;
      newVid.playsinline = false;
      newVid.autoplay = true;
      videos.current.appendChild(newVid);
      resize(videos.current);
    });
  }

  const removePeer = (socket_id) => {
    let videoEl = document.getElementById(socket_id);
    if (videoEl) {

      const tracks = videoEl.srcObject.getTracks();

      tracks.forEach(function (track) {
        track.stop();
      });

      videoEl.srcObject = null;
      videoEl.parentNode.removeChild(videoEl);
    }
    if (peers[socket_id]) {
      peers[socket_id].destroy();
    }
    delete peers[socket_id];
    resize(videos.current);
  }

  return {
    localStream,
    myVideo,
    videos
  };
};
