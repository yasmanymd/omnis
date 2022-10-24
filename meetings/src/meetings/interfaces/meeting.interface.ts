export interface IMeeting {
  name: string;
  code: string;
  description: string;
  participants: string[];
  start_time: number;
  end_time: number;
  status: string;
  created_at: number;
  created_by: string;
}