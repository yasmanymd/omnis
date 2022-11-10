import { IsNotEmpty, IsString } from "class-validator";

export class InitSendEventDto {
    @IsString()
    @IsNotEmpty()
    init_socket_id: string;
}