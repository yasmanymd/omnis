import { Body, Controller, Get, HttpException, HttpStatus, Inject, Post, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiTags, ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CreateMeetingResponseDto } from './interfaces/meetings/dto/create-meeting-response.dto';
import { CreateMeetingRequestDto } from './interfaces/meetings/dto/create-meeting-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceCreateMeetingResponse } from './interfaces/meetings/service-create-meeting-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';

@Controller('meetings')
export class MeetingsController {
  constructor(@Inject('MEETING_SERVICE') private readonly meetingService: ClientProxy) {}

  @Post()
  @ApiCreatedResponse({
    type: CreateMeetingResponseDto
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:meeting')
  async createMeeting(
    @Body() meetingRequest: CreateMeetingRequestDto
  ): Promise<CreateMeetingResponseDto> {
    const createMeetingResponse: IServiceCreateMeetingResponse = await firstValueFrom(
      this.meetingService.send(
        'meeting_create', 
        meetingRequest
      )
    );

    if (createMeetingResponse.status != HttpStatus.CREATED) {
      throw new HttpException({
        message: createMeetingResponse.message,
        data: null,
        errors: createMeetingResponse.errors,
      },
      createMeetingResponse.status);
    }
    return {
      message: createMeetingResponse.message,
      data: {
        meeting: createMeetingResponse.meeting
      },
      errors: null
    };
  }
}
