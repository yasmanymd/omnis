export interface IMeetingDeleteResponse {
  status: number;
  message: string;
  errors: { [key: string]: any } | null;
}