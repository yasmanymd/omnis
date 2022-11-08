"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
var WsGateway_1;
Object.defineProperty(exports, "__esModule", { value: true });
exports.WsGateway = void 0;
const common_1 = require("@nestjs/common");
const websockets_1 = require("@nestjs/websockets");
const socket_io_1 = require("socket.io");
const AnswerCallDto_1 = require("./dto/AnswerCallDto");
const CallUserEventDto_1 = require("./dto/CallUserEventDto");
const RejectCallDto_1 = require("./dto/RejectCallDto");
let WsGateway = WsGateway_1 = class WsGateway {
    constructor() {
        this.logger = new common_1.Logger(WsGateway_1.name);
        this.users = {};
    }
    async handleConnection(socket) {
        console.log('connected');
        const id = Math.floor(Math.random() * 10000);
        this.users[id] = socket.id;
        socket.emit('me', id);
        this.server.to(socket.id).emit('hey', 'Helloo');
        this.logger.log(`New Socket >> ${socket.id}`);
    }
    async handleDisconnect(socket) {
        this.logger.log(`Socket Disconnect >> ${socket.id}`);
        for (var f in this.users) {
            if (this.users.hasOwnProperty(f) && this.users[f] == socket.id) {
                delete this.users[f];
            }
        }
    }
    callUser(data) {
        this.logger.log(`Call User Event `);
        this.logger.log(`Emitting User Calling Event`);
        this.server.to(this.users[data.to]).emit('user.calling', { signal: data.signal, from: data.from });
    }
    answerCall(data) {
        this.logger.log(`Answer Call Event `);
        this.logger.log(`Emitting Call Accepted Event`);
        this.server.to(this.users[data.to]).emit('call.accepted', { signal: data.signal });
    }
    rejectCall(data) {
        this.logger.log(`Reject Call Event Event `);
        this.logger.log(`Emitting Call Rejected Event`);
        this.server.to(this.users[data.to]).emit('call.rejected', { from: data.from });
    }
    cancelCall(data) {
        this.logger.log(`Cancel Call Event  `);
        this.logger.log(`Emitting Call Cancelled Event`);
        this.server.to(this.users[data.to]).emit('call.cancelled', { from: data.from });
    }
    endCall(data) {
        this.logger.log(`End Call Event `);
        this.logger.log(`Emitting Call Ended Event`);
        this.server.to(this.users[data.to]).emit('call.ended', { from: data.from });
    }
};
__decorate([
    (0, websockets_1.WebSocketServer)(),
    __metadata("design:type", socket_io_1.Server)
], WsGateway.prototype, "server", void 0);
__decorate([
    (0, websockets_1.SubscribeMessage)('call.user'),
    __param(0, (0, websockets_1.MessageBody)(common_1.ValidationPipe)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [CallUserEventDto_1.CallUserEventDto]),
    __metadata("design:returntype", void 0)
], WsGateway.prototype, "callUser", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('answer.call'),
    __param(0, (0, websockets_1.MessageBody)(common_1.ValidationPipe)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [AnswerCallDto_1.AnswerCallDto]),
    __metadata("design:returntype", void 0)
], WsGateway.prototype, "answerCall", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('reject.call'),
    __param(0, (0, websockets_1.MessageBody)(common_1.ValidationPipe)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [RejectCallDto_1.RejectCallEventDto]),
    __metadata("design:returntype", void 0)
], WsGateway.prototype, "rejectCall", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('cancel.call'),
    __param(0, (0, websockets_1.MessageBody)(common_1.ValidationPipe)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [RejectCallDto_1.RejectCallEventDto]),
    __metadata("design:returntype", void 0)
], WsGateway.prototype, "cancelCall", null);
__decorate([
    (0, websockets_1.SubscribeMessage)('end.call'),
    __param(0, (0, websockets_1.MessageBody)(common_1.ValidationPipe)),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [RejectCallDto_1.RejectCallEventDto]),
    __metadata("design:returntype", void 0)
], WsGateway.prototype, "endCall", null);
WsGateway = WsGateway_1 = __decorate([
    (0, websockets_1.WebSocketGateway)({ transports: ['websocket', 'polling'], cors: true })
], WsGateway);
exports.WsGateway = WsGateway;
//# sourceMappingURL=ws.gateway.js.map