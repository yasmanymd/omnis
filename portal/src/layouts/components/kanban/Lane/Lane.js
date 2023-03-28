import React from "react";
import { Box, Card, CardContent, CardHeader, Divider, Paper, Stack, Typography } from "@mui/material";
import { useDroppable } from "@dnd-kit/core";
import { DragableCard } from "../Card/Card";

/**
 * Primary UI component for user interaction
 */
export const Lane = ({
  id,
  name,
  cards,
  formatDate,
  dragableOver,
  height
}) => {
  const { setNodeRef } = useDroppable({
    id
  });

  return (
    <Stack ref={setNodeRef} spacing={2} sx={{ minWidth: 275, height: '100%', padding: 2 }}>
      <Card sx={{ height: '100%', boxShadow: theme => `${theme.shadows[dragableOver ? 10 : 2]}` }}>
        <CardHeader
          title={name}
        />
        <CardContent>
          <Box sx={{ height: 'calc(' + height + ' - 102px)', overflow: 'auto' }}>
            {cards.sort((a, b) => b.date - a.date).map((card, index) =>
              <DragableCard
                key={index}
                id={card.id}
                name={card.name}
                laneId={id}
                date={card.date}
                formatDate={formatDate}
              />)}
          </Box>
        </CardContent>
      </Card>
    </Stack>
  );
};