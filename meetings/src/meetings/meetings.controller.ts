import { Controller, HttpStatus } from "@nestjs/common";
import { IMeetingCreateResponse } from "./interfaces/meeting-create-response.interface";
import { IMeeting } from "./interfaces/meeting.interface";
import { MeetingsService } from "./meetings.service";
import { MessagePattern } from '@nestjs/microservices';
import { generateId } from "../services/utils/utils";
import { IMeetingsSearchByUserResponse } from "./interfaces/meetings-search-by-user-response.interface";
import { IMeetingUpdateByIdResponse } from "./interfaces/meeting-update-by-id-response.interface";
import { IMeetingUpdateParams } from "./interfaces/meeting-update-params.interface";
import { IMeetingDeleteResponse } from "./interfaces/meeting-delete-response.interface";

@Controller()
export class MeetingsController {
  constructor(private readonly meetingService: MeetingsService) {}

  @MessagePattern('meetings_search_by_user')
  public async meetingsSearchByUser(user: string): Promise<IMeetingsSearchByUserResponse> {
    let result: IMeetingsSearchByUserResponse;

    if (user) {
      const meetings = await this.meetingService.getMeetingsByUser(user);
      result = {
        status: HttpStatus.OK,
        message: 'meetings_search_by_user_success',
        meetings
      };
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meetings_search_by_user_bad_request',
        meetings: null
      };
    }

    return result;
  }

  @MessagePattern('meeting_create')
  public async meetingCreate(meeting: IMeeting): Promise<IMeetingCreateResponse> {
    let result: IMeetingCreateResponse;

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
          meeting: createdMeeting,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'meeting_create_precondition_failed',
          meeting: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meeting_create_bad_request',
        meeting: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern('meeting_update_by_id')
  public async meetingUpdateById(params: {
    meeting: IMeetingUpdateParams;
    id: string;
    user: string;
  }): Promise<IMeetingUpdateByIdResponse> {
    let result: IMeetingUpdateByIdResponse;
    if (params.id) {
      try {
        const meeting = await this.meetingService.getMeetingById(params.id);
        if (meeting) {
          if (meeting.created_by === params.user) {
            const updatedMeeting = Object.assign(meeting, params.meeting);
            await updatedMeeting.save();
            result = {
              status: HttpStatus.OK,
              message: 'meeting_update_by_id_success',
              meeting: updatedMeeting,
              errors: null,
            };
          } else {
            result = {
              status: HttpStatus.FORBIDDEN,
              message: 'meeting_update_by_id_forbidden',
              meeting: null,
              errors: null,
            };
          }
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'meeting_update_by_id_not_found',
            meeting: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'meeting_update_by_id_precondition_failed',
          meeting: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'meeting_update_by_id_bad_request',
        meeting: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern('meeting_delete_by_id')
  public async meetingDeleteForUser(params: {
    user: string;
    id: string;
  }): Promise<IMeetingDeleteResponse> {
    let result: IMeetingDeleteResponse;

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