export interface IWfCandidate {
  candidate_id: string;
  name: string;
  status: string;
  modified_date: number;
}

export interface IWorkflow {
  _id: string;
  workflow_template_id: string;
  candidates: IWfCandidate[];
}