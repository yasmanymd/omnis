import { ICandidate } from './candidate.interface';

export interface IServiceCandidateUpdateByIdResponse {
  status: number;
  message: string;
  candidate: ICandidate | null;
  errors: { [key: string]: any };
}