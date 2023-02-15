import { Document } from 'mongoose';

export interface INote {
  _id: string;
  note: string;
  candidate_id: string;
  created_at: number;
  created_by: string;
  modified_by: string;
}