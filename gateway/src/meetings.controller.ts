import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CreateMeetingRequestDto } from './interfaces/meetings/dto/create-meeting-request.dto';
import { Observable } from 'rxjs';
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
  @Permissions('create-meeting')
  async createMeeting(
    @Req() req: { user: IUser },
    @Body() meetingRequest: CreateMeetingRequestDto
  ): Promise<Observable<ResponseDto<IMeeting>>> {
    return this.meetingService.send({ cmd: 'meeting_create' },
      {
        ...meetingRequest,
        created_by: req.user.email
      }
    );
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read-meeting')
  @ApiOkResponse({
    type: ResponseDto<IMeeting[]>,
    description: 'List of meetings of user'
  })
  public async getMeetings(
    @Req() req: { user: IUser }
  ): Promise<Observable<ResponseDto<IMeeting[]>>> {
    return this.meetingService.send({ cmd: 'meetings_search_by_user' }, req.user.email);
  }

  @Get('/search?')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read-meeting')
  @ApiOkResponse({
    type: ResponseDto<IMeeting[]>,
    description: 'List of meetings'
  })
  public async getMeeting(
    @Query('code') code: string
  ): Promise<Observable<ResponseDto<IMeeting[]>>> {
    return this.meetingService.send({ cmd: 'meetings_search_by_code' }, code);
  }


  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete-meeting')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete meeting'
  })
  public async deleteMeeting(
    @Req() req: { user: IUser },
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<null>>> {
    return this.meetingService.send({ cmd: 'meeting_delete_by_id' }, {
      id: id,
      user: req.user.email
    });
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('update-meeting')
  @ApiOkResponse({
    type: ResponseDto<IMeeting>,
    description: 'Update meeting'
  })
  public async updateMeeting(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() meetingRequest: UpdateMeetingRequestDto,
  ): Promise<Observable<ResponseDto<IMeeting>>> {
    return this.meetingService.send({ cmd: 'meeting_update_by_id' }, {
      id: id,
      user: req.user.email,
      meeting: meetingRequest,
    });
  }
}
