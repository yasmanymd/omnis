export interface IJob {
  _id: string;
  title: string;
  description: string;
  contacts: { [key: string]: any };
  tags: string[];
  client_id: string;
}
