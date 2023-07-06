import { createContext, useState, useEffect } from 'react'

const initialConfig = {
  signalingServerUrl: '',
  keycloakUrl: '',
  omnisUrl: ''
};

export const ConfigContext = createContext(initialConfig);

export const ConfigProvider = ({ children }) => {
  const [config, setConfig] = useState({ ...initialConfig })

  useEffect(() => {
    (async () => {
      try {
        const response = await fetch(encodeURI('/api/config'), {
          method: 'GET',
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          }
        });
        const result = await response.json();
        setConfig(result);
      } catch (err) {
      }
    })();
  }, []);

  return <ConfigContext.Provider value={{ config }}>{children}</ConfigContext.Provider>
}

export const ConfigConsumer = ConfigContext.Consumer;