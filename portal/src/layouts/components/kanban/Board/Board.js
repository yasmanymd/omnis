import { Box, Divider, Paper, Stack, Typography } from "@mui/material";
import React, { useState } from "react";
import { Lane } from "../Lane/Lane";
import { DndContext, DragEndEvent, DragStartEvent, DragOverEvent, DragOverlay } from "@dnd-kit/core";
import { Card } from "../Card/Card";

/**
 * Primary UI component for user interaction
 */
export const Board = ({
  initLanes,
  formatDate,
  onChange,
  height
}) => {
  const [lanes, setLanes] = useState(initLanes);
  const [active, setActive] = useState();
  const [dragging, setDragging] = useState(false);
  const [laneActive, setLaneActive] = useState(null);

  const handleDragStart = (event) => {
    setActive(event?.active?.data?.current);
    setDragging(true);
  }

  const handleDragOver = (event) => {
    if (event?.active?.data?.current?.laneId != event?.over?.id) {
      if (event?.over?.id) {
        setLaneActive(event?.over?.id);
      } else {
        setLaneActive(null);
      }
    } else {
      setLaneActive(null);
    }
  }

  const handleDragEnd = (event) => {
    const card = event?.active?.data?.current;
    const laneSourceId = card?.laneId;
    const laneTargetId = event?.over?.id;
    if (card && laneSourceId && laneTargetId && laneSourceId != laneTargetId) {
      setLanes((lanes) => {
        let result = [...lanes];
        let laneSourceIndex = lanes.findIndex(item => item.id == laneSourceId);
        let laneTargetIndex = lanes.findIndex(item => item.id == laneTargetId);
        let newCard = {
          id: card.id,
          name: card.name,
          date: new Date().getTime(),
          laneId: laneTargetId,
          formatDate: card.formatDate,
          dragging: card.dragging
        };
        result[laneTargetIndex].cards = result[laneTargetIndex].cards.concat(newCard);
        result[laneSourceIndex].cards = result[laneSourceIndex].cards.filter(item => item.id != card.id);
        if (onChange) {
          onChange({
            cardId: newCard.id,
            laneId: laneTargetId,
            date: newCard.date
          });
        }
        return result;
      });
    }
    setActive(undefined);
    setDragging(false);
    setLaneActive(null);
  }

  return (
    <DndContext
      onDragStart={handleDragStart}
      onDragOver={handleDragOver}
      onDragEnd={handleDragEnd}
      autoScroll={false}
    >

      <Stack spacing={2} height={height} direction="row" overflow={"auto"}>
        {lanes.map((lane, index) => <Lane
          key={index}
          id={lane.id}
          name={lane.name}
          cards={lane.cards}
          formatDate={formatDate}
          dragableOver={laneActive == lane.id}
        />
        )}
      </Stack>

      <DragOverlay>
        {
          active ?
            <Card
              id={active.id}
              name={active.name}
              date={active.date}
              laneId={active.laneId}
              formatDate={active.formatDate}
              dragging={dragging}
            /> : null
        }
      </DragOverlay>
    </DndContext>
  );
};
