import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { ICandidate } from '../interfaces/candidate.interface';

export type CandidateDocument = Candidate & Document;

@Schema({ strict: false })
export class Candidate implements ICandidate {
  _id: string;

  @Prop({ required: true })
  name: string;

  @Prop({ required: false })
  title: string;

  @Prop({ required: false })
  tags: string[];

  contacts: { [key: string]: any };

  @Prop({ required: false })
  status: string;

  @Prop({ required: false })
  salary: string;

  @Prop({ required: true })
  created_at: number;

  @Prop({ required: true })
  created_by: string;
}

export const CandidateSchema = SchemaFactory.createForClass(Candidate);