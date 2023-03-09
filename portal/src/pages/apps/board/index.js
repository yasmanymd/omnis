import { Board } from "@yasmanymd/elementa";

import { Card, Grid, Box, Stack, Paper, Typography, Divider, CardContent } from "@mui/material";
import BoardWrapper from "src/@core/styles/libs/board";

const AppBoard = () => {
  const init = {
    initLanes: [{
      id: 1,
      name: "To do",
      cards: [
        {
          id: 1,
          name: 'Alan Rickman',
          date: new Date('1/12/2023').getTime()
        },
        {
          id: 2,
          name: 'Natalie Portman',
          date: new Date('2/24/2023').getTime()
        }
      ]
    },
    {
      id: 2,
      name: "Working",
      cards: [
        {
          id: 3,
          name: 'Steven Spielberg',
          date: new Date('7/11/2020').getTime()
        },
        {
          id: 4,
          name: 'Benicio del Toro',
          date: new Date('1/2/2021').getTime()
        }
      ]
    },
    {
      id: 3,
      name: "Done",
      cards: [
        {
          id: 5,
          name: 'Jennifer Aniston',
          date: new Date('8/3/2022').getTime()
        }
      ]
    },
    {
      id: 4,
      name: "Undo",
      cards: [
        {
          id: 6,
          name: 'Ana de Armas',
          date: new Date('8/11/2019').getTime()
        },
        {
          id: 7,
          name: 'Viola Davis',
          date: new Date('1/1/2018').getTime()
        }
      ]
    },
    {
      id: 5,
      name: "Reach out",
      cards: [
        {
          id: 8,
          name: 'Ridley Scott',
          date: new Date('12/11/2015').getTime()
        },
        {
          id: 9,
          name: 'Joaquin Phoenix',
          date: new Date('2/2/2022').getTime()
        }
      ]
    },
    {
      id: 6,
      name: "Finished",
      cards: [
        {
          id: 10,
          name: 'Tom Cruise',
          date: new Date('7/2/2021').getTime()
        },
        {
          id: 11,
          name: 'Brad Pitt',
          date: new Date('11/12/2011').getTime()
        }
      ]
    }
    ],
    formatDate: (date) => Intl.DateTimeFormat("en-US").format(date),
    height: '640px'
  };

  return (
    <Grid container spacing={6}>
      <Grid item xs={12}>
        <Card sx={{ padding: 4 }}>
          <BoardWrapper>
            <Board {...init} />
          </BoardWrapper>
        </Card>
        <Card sx={{ padding: 4 }}>
          <Box sx={{ height: init.height }}>
            <Stack spacing={2} height="100%" direction="row" overflow={"auto"}>
              <Stack spacing={2} sx={{ minWidth: 275, height: '100%' }}>
                <Paper elevation={1} sx={{ height: '100%' }}>
                  <Typography sx={{ fontSize: 16, fontWeight: 'bold', margin: 1 }} color="text.secondary" gutterBottom>
                    To do
                  </Typography>
                  <Divider />
                  <Box sx={{ height: 'calc(100% - 42px)', maxHeight: '100%', overflow: 'auto' }}>
                    <Card sx={{ margin: 2 }}>
                      <CardContent sx={{ '&:last-child': { paddingBottom: '16px' } }}>
                        <Typography sx={{ fontSize: 16, fontWeight: 'bold' }} color="text.secondary" gutterBottom>
                          Yasmany Molina Diaz
                        </Typography>
                        <Typography sx={{ fontSize: 14, textAlign: 'right' }} color="text.secondary" gutterBottom>
                          02/12/2023
                        </Typography>
                      </CardContent>
                    </Card>
                  </Box>
                </Paper>
              </Stack>
            </Stack>
          </Box>
        </Card>
      </Grid>
    </Grid>
  )
};

export default AppBoard;