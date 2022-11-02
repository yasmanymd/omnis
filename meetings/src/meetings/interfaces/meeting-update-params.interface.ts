export interface IMeetingUpdateParams {
  name: string;
  description: string;
  participants: string[];
  start_time: number;
  duration: number;
  max_person: number;
}