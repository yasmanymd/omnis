export interface IServiceMeetingDeleteResponse {
  status: number;
  message: string;
  errors: { [key: string]: any };
}