export interface ICandidateDeleteResponse {
  status: number;
  message: string;
  errors: { [key: string]: any } | null;
}