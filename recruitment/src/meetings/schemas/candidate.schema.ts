import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { ICandidate } from '../interfaces/candidate.interface';

export type CandidateDocument = Candidate & Document;

@Schema()
export class Candidate implements ICandidate {
  _id: string;

  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  created_at: number;

  @Prop({ required: true })
  created_by: string;
}

export const CandidateSchema = SchemaFactory.createForClass(Candidate);