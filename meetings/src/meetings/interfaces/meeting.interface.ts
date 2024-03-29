import { Document } from 'mongoose';

export interface IMeeting {
  _id: string;
  name: string;
  code: string;
  description: string;
  participants: string[];
  start_time: number;
  duration: number;
  max_person: number;
  status: string;
  created_at: number;
  created_by: string;
}