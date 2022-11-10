import { IsDefined, IsNotEmpty, IsString } from "class-validator"

export class SignalEventDto {
    @IsString()
    @IsNotEmpty()
    socket_id: string

    @IsDefined()
    signal: any
}