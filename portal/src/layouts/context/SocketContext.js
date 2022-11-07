import React, { createContext, useState, useRef, useEffect } from 'react';
import toast from 'react-hot-toast';
import ErrorDetails from '../components/ErrorDetails';

const SocketContext = createContext();

const ContextProvider = ({ children }) => {
  const [stream, setStream] = useState(null);
  const [name, setName] = useState('');

  const videoRef = useRef(null);

  useEffect(() => {
    navigator.mediaDevices.getUserMedia({ video: true })
      .then((currentStream) => {
        setStream(currentStream);
        setTimeout(() => {
          videoRef.current.srcObject = currentStream;          
        }, 500);
      })
      .catch(error => {
        toast.error(<ErrorDetails message='Error accessing media devices.' errors={{'details': {message: error.message}}} />);
      });
  }, [videoRef]);

  return (
    <SocketContext.Provider value={{
      myVideo: videoRef,
      stream
    }}
    >
      {children}
    </SocketContext.Provider>
  );
};

export { ContextProvider, SocketContext };
