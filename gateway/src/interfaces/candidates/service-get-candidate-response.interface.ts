import { ICandidate } from './candidate.interface';

export interface IServiceGetCandidateResponse {
  status: number;
  message: string;
  candidate: ICandidate | null;
  errors: { [key: string]: any };
}