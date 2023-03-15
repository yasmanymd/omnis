export interface IJob {
  title: string;
  description: string;
  contacts: { [key: string]: string };
  tags: string[];
  client_id: string;
  workflow_id: string;
}
