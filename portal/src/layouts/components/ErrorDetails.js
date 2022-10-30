import React, { useState, forwardRef, useCallback } from "react";
import { useSnackbar, SnackbarContent } from "notistack";
import Alert from '@mui/material/Alert';
import AlertTitle from '@mui/material/AlertTitle';

const ErrorDetails = forwardRef((props, ref) => {
  let msgs = [];
  for (const prop in props.errors) {
    const error = props.errors[prop];
    msgs.push(<li key={prop}>{error.message}</li>);
  }
  return (
    <div>
      <div><b>{props.message}</b></div>
      <ul>{msgs}</ul>
    </div>
  );
});

export default ErrorDetails;