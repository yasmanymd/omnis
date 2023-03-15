import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { IWfCandidate, IWorkflow } from '../interfaces/workflow.interface';

export type WorkflowDocument = Workflow & Document;

@Schema({ strict: false })
export class Workflow implements IWorkflow {
  _id: string;

  @Prop({ required: true })
  workflow_template_id: string;

  @Prop({ required: true })
  candidates: IWfCandidate[];
}

export const WorkflowSchema = SchemaFactory.createForClass(Workflow);