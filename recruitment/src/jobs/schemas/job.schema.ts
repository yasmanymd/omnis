import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { IJob } from '../interfaces/job.interface';

export type JobDocument = Job & Document;

@Schema({ strict: false })
export class Job implements IJob {
  _id: string;

  @Prop({ required: true })
  title: string;

  @Prop({ required: false })
  description: string;

  contacts: { [key: string]: any };

  @Prop({ required: false })
  tags: string[];

  @Prop({ required: true })
  client_id: string;
}

export const JobSchema = SchemaFactory.createForClass(Job);