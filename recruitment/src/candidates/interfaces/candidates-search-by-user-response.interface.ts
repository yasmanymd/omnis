import { ICandidate } from './candidate.interface';

export interface ICandidatesSearchByUserResponse {
  status: number;
  message: string;
  candidates: ICandidate[];
}