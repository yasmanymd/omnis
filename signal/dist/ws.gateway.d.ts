import { OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Socket, Server } from 'socket.io';
import { AnswerCallDto } from './dto/AnswerCallDto';
import { CallUserEventDto } from './dto/CallUserEventDto';
import { RejectCallEventDto } from './dto/RejectCallDto';
export declare class WsGateway implements OnGatewayConnection, OnGatewayDisconnect {
    private readonly logger;
    server: Server;
    private users;
    handleConnection(socket: Socket): Promise<void>;
    handleDisconnect(socket: Socket): Promise<void>;
    callUser(data: CallUserEventDto): void;
    answerCall(data: AnswerCallDto): void;
    rejectCall(data: RejectCallEventDto): void;
    cancelCall(data: RejectCallEventDto): void;
    endCall(data: RejectCallEventDto): void;
}
