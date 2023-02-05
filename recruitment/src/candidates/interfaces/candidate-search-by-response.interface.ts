import { ICandidate } from './candidate.interface';

export interface ICandidateSearchByResponse {
  status: number;
  message: string;
  candidate: ICandidate;
}