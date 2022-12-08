export interface ICandidateUpdateParams {
  name: string;
  title: string;
  contacts: { [key: string]: any };
  status: string;
  salary: string;
}