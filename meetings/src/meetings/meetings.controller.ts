import { Controller, HttpStatus } from "@nestjs/common";
import { IMeetingCreateResponse } from "./interfaces/meeting-create-response.interface";
import { IMeeting } from "./interfaces/meeting.interface";
import { MeetingsService } from "./meetings.service";
import { MessagePattern } from '@nestjs/microservices';
import { generateId } from "../services/utils/utils";

@Controller()
export class MeetingsController {
  constructor(private readonly meetingService: MeetingsService) {}

  @MessagePattern('meeting_create')
  public async meetingCreate(meeting: IMeeting): Promise<IMeetingCreateResponse> {
    let result: IMeetingCreateResponse;

    if (meeting) {
      try {
        const createdMeeting = await this.meetingService.createMeeting(
          {
            ...meeting,
            code: generateId(), 
            status: 'created',
            created_at: +new Date()
          }
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
}