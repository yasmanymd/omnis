import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CreateMeetingResponseDto } from './interfaces/meetings/dto/create-meeting-response.dto';
import { CreateMeetingRequestDto } from './interfaces/meetings/dto/create-meeting-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceCreateMeetingResponse } from './interfaces/meetings/service-create-meeting-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { GetMeetingsResponseDto } from './interfaces/meetings/dto/get-meetings-response.dto';
import { IServiceGetMeetingsResponse } from './interfaces/meetings/service-get-meetings-response.interface';
import { DeleteMeetingResponseDto } from './interfaces/meetings/dto/delete-meeting-response.dto';
import { IUser } from './interfaces/user/user.interface';
import { IServiceMeetingDeleteResponse } from './interfaces/meetings/service-meeting-delete-response.interface';
import { UpdateMeetingResponseDto } from './interfaces/meetings/dto/update-meeting-response.dto';
import { UpdateMeetingRequestDto } from './interfaces/meetings/dto/update-meeting-request.dto';
import { IServiceMeetingUpdateByIdResponse } from './interfaces/meetings/service-meeting-update-by-id-response.interface';

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
    @Req() req: { user: IUser },
    @Body() meetingRequest: CreateMeetingRequestDto
  ): Promise<CreateMeetingResponseDto> {
    const createMeetingResponse: IServiceCreateMeetingResponse = await firstValueFrom(
      this.meetingService.send(
        'meeting_create', 
        {
          ...meetingRequest,
          created_by: req.user.email
        }
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

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:meeting')
  @ApiOkResponse({
    type: GetMeetingsResponseDto,
    description: 'List of meetings of user'
  })
  public async getMeetings(
    @Req() req: { user: IUser }
  ): Promise<GetMeetingsResponseDto> {
    const meetingsResponse: IServiceGetMeetingsResponse = await firstValueFrom(
      this.meetingService.send('meetings_search_by_user', req.user.email),
    );

    return {
      message: meetingsResponse.message,
      data: {
        meetings: meetingsResponse.meetings
      },
      errors: null,
    };
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:meeting')
  @ApiOkResponse({
    type: DeleteMeetingResponseDto,
    description: 'Delete meeting'
  })
  public async deleteMeeting(
    @Req() req: { user: IUser },
    @Param('id') id: string,
  ): Promise<DeleteMeetingResponseDto> {
    const deleteMeetingResponse: IServiceMeetingDeleteResponse = await firstValueFrom(
      this.meetingService.send('meeting_delete_by_id', {
        id: id,
        user: req.user.email
      }),
    );

    if (deleteMeetingResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: deleteMeetingResponse.message,
          errors: deleteMeetingResponse.errors,
          data: null,
        },
        deleteMeetingResponse.status,
      );
    }

    return {
      message: deleteMeetingResponse.message,
      data: null,
      errors: null,
    };
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:meeting')
  @ApiOkResponse({
    type: UpdateMeetingResponseDto,
    description: 'Update meeting'
  })
  public async updateMeeting(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() meetingRequest: UpdateMeetingRequestDto,
  ): Promise<UpdateMeetingResponseDto> {
    const updateMeetingResponse: IServiceMeetingUpdateByIdResponse = await firstValueFrom(
      this.meetingService.send('meeting_update_by_id', {
        id: id,
        user: req.user.email,
        meeting: meetingRequest,
      }),
    );

    if (updateMeetingResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: updateMeetingResponse.message,
          errors: updateMeetingResponse.errors,
          data: null,
        },
        updateMeetingResponse.status,
      );
    }

    return {
      message: updateMeetingResponse.message,
      data: {
        meeting: updateMeetingResponse.meeting,
      },
      errors: null,
    };
  }
}
