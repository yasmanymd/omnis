import { ICandidate } from './candidate.interface';

export interface IServiceGetCandidatesResponse {
  status: number;
  message: string;
  candidates: ICandidate[] | null;
  errors: { [key: string]: any };
}