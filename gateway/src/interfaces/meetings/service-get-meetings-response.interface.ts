import { IMeeting } from './meeting.interface';

export interface IServiceGetMeetingsResponse {
  status: number;
  message: string;
  meetings: IMeeting[] | null;
  errors: { [key: string]: any };
}