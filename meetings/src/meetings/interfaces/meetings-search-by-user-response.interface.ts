import { IMeeting } from './meeting.interface';

export interface IMeetingsSearchByUserResponse {
  status: number;
  message: string;
  meetings: IMeeting[];
}