import React from "react";
import { useDraggable } from '@dnd-kit/core';
import { Card as CardUI, CardContent, Typography, Box, Divider } from "@mui/material";

// ** Hooks Imports
import useBgColor from 'src/@core/hooks/useBgColor'

/**
 * Primary UI component for user interaction
 */
export const Card = ({
  id,
  name,
  date,
  laneId,
  formatDate,
  dragging
}) => {
  const colorClasses = useBgColor();

  return (
    <Box
      sx={{
        width: '95%',
        display: 'flex',
        borderRadius: '4px',
        margin: 2,
        color: 'text.primary',
        p: theme => theme.spacing(2.25, 2.75),
        backgroundColor: colorClasses.primaryLight.backgroundColor,
        flexDirection: 'column'
      }}
    >
      <Typography sx={{ fontWeight: 500, fontSize: '0.875rem' }}>{name}</Typography>
      <Typography component='sub' variant='caption' sx={{ lineHeight: 1.5, alignSelf: 'flex-end' }}>
        {formatDate ? formatDate(date) : date}
      </Typography>

    </Box>
  );
};

export const DragableCard = ({
  id,
  name,
  date,
  laneId,
  formatDate
}) => {
  const { attributes, listeners, setNodeRef } = useDraggable({
    id: id,
    data: { id, name, date, laneId, formatDate }
  });

  return (
    <div ref={setNodeRef} {...listeners} {...attributes} style={{ cursor: 'grab' }}>
      <Card
        id={id}
        name={name}
        date={date}
        laneId={laneId}
        formatDate={formatDate}
      />
    </div>
  );
};