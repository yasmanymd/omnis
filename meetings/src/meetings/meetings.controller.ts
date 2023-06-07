import { Controller, HttpStatus } from "@nestjs/common";
import { IMeeting } from "./interfaces/meeting.interface";
import { MeetingsService } from "./meetings.service";
import { MessagePattern } from '@nestjs/microservices';
import { generateId } from "../services/utils/utils";
import { IResponse } from "../common/response.interface";


@Controller()
export class MeetingsController {
  constructor(private readonly meetingService: MeetingsService) { }

  @MessagePattern({ cmd: 'meetings_search_by_user' })
  public async meetingsSearchByUser(user: string): Promise<IResponse<IMeeting[]>> {
    let result: IResponse<IMeeting[]>;

    if (user) {
      const meetings = await this.meetingService.getMeetingsByUser(user);
      result = {
        status: HttpStatus.OK,
        message: 'meetings_search_by_user_success',
        data: meetings
      };
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meetings_search_by_user_bad_request',
        data: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'meetings_search_by_code' })
  public async meetingsSearchByCode(code: string): Promise<IResponse<IMeeting[]>> {
    let result: IResponse<IMeeting[]>;

    if (code) {
      const meetings = await this.meetingService.getMeetingsByCode(code);
      result = {
        status: HttpStatus.OK,
        message: 'meetings_search_by_code_success',
        data: meetings
      };
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meetings_search_by_code_bad_request',
        data: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'meeting_create' })
  public async meetingCreate(meeting: IMeeting): Promise<IResponse<IMeeting>> {
    let result: IResponse<IMeeting>;

    if (meeting) {
      try {
        const createdMeeting = await this.meetingService.createMeeting(
          Object.assign(meeting, {
            code: generateId(),
            status: 'created',
            created_at: +new Date()
          })
        );
        result = {
          status: HttpStatus.CREATED,
          message: 'meeting_create_success',
          data: createdMeeting,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'meeting_create_precondition_failed',
          data: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meeting_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'meeting_update_by_id' })
  public async meetingUpdateById(params: {
    meeting: IMeeting;
    id: string;
    user: string;
  }): Promise<IResponse<IMeeting>> {
    let result: IResponse<IMeeting>;
    if (params.id) {
      try {
        const meeting = await this.meetingService.getMeetingById(params.id);
        if (meeting) {
          if (meeting.created_by === params.user) {
            const updatedMeeting = await this.meetingService.updateMeetingById(meeting._id, Object.assign(meeting, params.meeting));
            result = {
              status: HttpStatus.OK,
              message: 'meeting_update_by_id_success',
              data: updatedMeeting,
              errors: null,
            };
          } else {
            result = {
              status: HttpStatus.FORBIDDEN,
              message: 'meeting_update_by_id_forbidden',
              data: null,
              errors: null,
            };
          }
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'meeting_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'meeting_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meeting_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'meeting_delete_by_id' })
  public async meetingDeleteForUser(params: {
    user: string;
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.user && params.id) {
      try {
        const meeting = await this.meetingService.getMeetingById(params.id);

        if (meeting) {
          if (meeting.created_by === params.user) {
            await this.meetingService.removeMeetingById(params.id);
            result = {
              status: HttpStatus.OK,
              message: 'meeting_delete_by_id_success',
              errors: null,
            };
          } else {
            result = {
              status: HttpStatus.FORBIDDEN,
              message: 'meeting_delete_by_id_forbidden',
              errors: null,
            };
          }
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'meeting_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'meeting_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meeting_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}