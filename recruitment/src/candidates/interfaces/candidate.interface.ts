import { Document } from 'mongoose';

export interface ICandidate {
  _id: string;
  name: string;
  title: string;
  tags: string[];
  contacts: { [key: string]: any };
  status: string;
  salary: string;
  created_at: number;
  created_by: string;
}

export interface ICandidateImport extends ICandidate {
  token: string;
}