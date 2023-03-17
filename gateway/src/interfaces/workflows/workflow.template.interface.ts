export interface IStatus {
  name: string;
  type?: 'init' | 'end' | undefined;
}
export interface IWorkflowTemplate {
  _id: string;
  name: string;
  //Only 1 status should be marked as init
  status: IStatus[];
}
