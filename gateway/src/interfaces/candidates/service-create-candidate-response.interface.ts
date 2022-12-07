import { ICandidate } from './candidate.interface';

export interface IServiceCreateCandidateResponse {
  status: number;
  message: string;
  candidate: ICandidate | null;
  errors: { [key: string]: any };
}