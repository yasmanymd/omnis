import { Document } from 'mongoose';

export interface IToken {
  user: string;
  token: string;
}