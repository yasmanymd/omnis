import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { IStatus, IWorkflowTemplate } from '../interfaces/workflow.template.interface';

export type WorkflowTemplateDocument = WorkflowTemplate & Document;

@Schema({ strict: false })
export class WorkflowTemplate implements IWorkflowTemplate {
  _id: string;

  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  status: IStatus[];
}

export const WorkflowTemplateSchema = SchemaFactory.createForClass(WorkflowTemplate);