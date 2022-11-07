import React, { forwardRef } from "react";

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