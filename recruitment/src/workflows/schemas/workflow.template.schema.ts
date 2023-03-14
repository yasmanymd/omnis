import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { IWorkflowTemplate } from '../interfaces/workflow.template.interface';

export type WorkflowTemplateDocument = WorkflowTemplate & Document;

@Schema({ strict: false })
export class WorkflowTemplate implements IWorkflowTemplate {
  _id: string;

  @Prop({ required: true })
  status: string[];

  @Prop({ required: true })
  initial_status: string;
}

export const WorkflowTemplateSchema = SchemaFactory.createForClass(WorkflowTemplate);