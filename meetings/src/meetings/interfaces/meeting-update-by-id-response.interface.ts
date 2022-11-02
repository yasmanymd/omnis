import { IMeeting } from './meeting.interface';

export interface IMeetingUpdateByIdResponse {
  status: number;
  message: string;
  meeting: IMeeting | null;
  errors: { [key: string]: any } | null;
}