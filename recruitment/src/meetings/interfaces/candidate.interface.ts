import { Document } from 'mongoose';

export interface ICandidate {
  _id: string;
  name: string;
  created_at: number;
  created_by: string;
}