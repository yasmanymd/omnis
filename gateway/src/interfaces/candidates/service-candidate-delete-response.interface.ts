export interface IServiceCandidateDeleteResponse {
  status: number;
  message: string;
  errors: { [key: string]: any };
}