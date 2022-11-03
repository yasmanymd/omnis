import { IMeeting } from './meeting.interface';

export interface IServiceMeetingUpdateByIdResponse {
  status: number;
  message: string;
  meeting: IMeeting | null;
  errors: { [key: string]: any };
}