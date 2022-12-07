import { ICandidate } from './candidate.interface';

export interface ICandidateCreateResponse {
  status: number;
  message: string;
  candidate: ICandidate | null;
  errors: { [key: string]: any } | null;
}