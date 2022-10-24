import { IMeeting } from './meeting.interface';

export interface IServiceCreateMeetingResponse {
  status: number;
  message: string;
  meeting: IMeeting | null;
  errors: { [key: string]: any };
}