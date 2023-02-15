import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CreateMeetingRequestDto } from './interfaces/meetings/dto/create-meeting-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceResponse } from './interfaces/common/service-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { UpdateMeetingRequestDto } from './interfaces/meetings/dto/update-meeting-request.dto';
import { IMeeting } from './interfaces/meetings/meeting.interface';
import { ResponseDto } from './interfaces/common/response.dto';

@Controller('meetings')
export class MeetingsController {
  constructor(@Inject('MEETING_SERVICE') private readonly meetingService: ClientProxy) { }

  @Post()
  @ApiCreatedResponse({
    type: ResponseDto<IMeeting>
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:meeting')
  async createMeeting(
    @Req() req: { user: IUser },
    @Body() meetingRequest: CreateMeetingRequestDto
  ): Promise<ResponseDto<IMeeting>> {
    const createMeetingResponse: IServiceResponse<IMeeting> = await firstValueFrom(
      this.meetingService.send({ cmd: 'meeting_create' },
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
      data: createMeetingResponse.data,
      errors: null
    };
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:meeting')
  @ApiOkResponse({
    type: ResponseDto<IMeeting[]>,
    description: 'List of meetings of user'
  })
  public async getMeetings(
    @Req() req: { user: IUser }
  ): Promise<ResponseDto<IMeeting[]>> {
    const meetingsResponse: IServiceResponse<IMeeting[]> = await firstValueFrom(
      this.meetingService.send({ cmd: 'meetings_search_by_user' }, req.user.email),
    );

    return {
      message: meetingsResponse.message,
      data: meetingsResponse.data,
      errors: null,
    };
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:meeting')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete meeting'
  })
  public async deleteMeeting(
    @Req() req: { user: IUser },
    @Param('id') id: string,
  ): Promise<ResponseDto<null>> {
    const deleteMeetingResponse: IServiceResponse<null> = await firstValueFrom(
      this.meetingService.send({ cmd: 'meeting_delete_by_id' }, {
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
    type: ResponseDto<IMeeting>,
    description: 'Update meeting'
  })
  public async updateMeeting(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() meetingRequest: UpdateMeetingRequestDto,
  ): Promise<ResponseDto<IMeeting>> {
    const updateMeetingResponse: IServiceResponse<IMeeting> = await firstValueFrom(
      this.meetingService.send({ cmd: 'meeting_update_by_id' }, {
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
      data: updateMeetingResponse.data,
      errors: null,
    };
  }
}
