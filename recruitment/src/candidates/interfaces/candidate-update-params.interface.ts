export interface ICandidateUpdateParams {
  name: string;
  title: string;
  tags: string[];
  contacts: { [key: string]: any };
  status: string;
  salary: string;
}