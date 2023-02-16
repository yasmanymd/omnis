export interface ICandidate {
  name: string;
  title: string;
  tags: string[];
  contacts: { [key: string]: string };
  status: string;
  salary: string;
  created_at: number;
  created_by: string;
}
