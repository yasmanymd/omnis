export interface IClient {
  _id: string;
  name: string;
  description: string;
  contacts: { [key: string]: any };
}
