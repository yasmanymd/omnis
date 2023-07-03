import { useEffect, useState } from "react";

export default function useConfig() {
  const [config, setConfig] = useState({});

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

  return config;
}