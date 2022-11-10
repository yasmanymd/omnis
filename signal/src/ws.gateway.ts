import { Logger, ValidationPipe } from '@nestjs/common';
import { SubscribeMessage, WebSocketGateway, OnGatewayConnection, WebSocketServer, MessageBody, OnGatewayDisconnect, ConnectedSocket } from '@nestjs/websockets';
import { Socket, Server } from 'socket.io'
import { InitSendEventDto } from './dto/InitSendEventDto';
import { SignalEventDto } from './dto/SignalEventDto';

@WebSocketGateway({ transports: ['websocket', 'polling'], cors: true })
export class WsGateway implements OnGatewayConnection, OnGatewayDisconnect {

  private readonly logger = new Logger(WsGateway.name);

  @WebSocketServer()
  server: Server;

  private peers = {};

  async handleConnection(socket: Socket) {
    this.peers[socket.id] = socket;
    for (let prop in this.peers) {
      const peer = this.peers[prop];
      if (peer.id != socket.id) {
        peer.emit('initReceive', socket.id);
      }
    }
    this.logger.log(`New Socket >> ${socket.id}`)
  }

  async handleDisconnect(socket: Socket) {
    this.logger.log(`Socket Disconnect >> ${socket.id}`);
    socket.broadcast.emit('removePeer', socket.id);
    delete this.peers[socket.id];
  }

  @SubscribeMessage('signal')
  signal(@MessageBody(ValidationPipe) data: SignalEventDto, @ConnectedSocket() socket: Socket) {
    this.logger.log(`Signal Event `);
    if (!this.peers[data.socket_id]) {
      return this.peers[data.socket_id].emit('signal', {
        socket_id: socket.id,
        signal: data.signal
      });
    }
  }

  @SubscribeMessage('initSend')
  answerCall(@MessageBody(ValidationPipe) data: InitSendEventDto, @ConnectedSocket() socket: Socket) {
    this.logger.log(`Init Send Event `);
    this.peers[data.init_socket_id].emit('initSend', socket.id);
  }
}
