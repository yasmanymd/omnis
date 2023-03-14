export interface IWfCandidate {
  candidate_id: string;
  name: string;
  status: string;
  modified_date: number;
}

export interface IWorkflow {
  _id: string;
  template: string;
  candidates: IWfCandidate[];
}