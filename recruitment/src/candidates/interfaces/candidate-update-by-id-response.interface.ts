import { ICandidate } from './candidate.interface';

export interface ICandidateUpdateByIdResponse {
  status: number;
  message: string;
  candidate: ICandidate | null;
  errors: { [key: string]: any } | null;
}