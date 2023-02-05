import { ICandidate } from './candidate.interface';

export interface ICandidatesSearchByResponse {
  status: number;
  message: string;
  candidates: ICandidate[];
}