import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IWorkflow } from "./interfaces/workflow.interface";
import { WorkflowDocument } from "./schemas/workflow.schema";
import { WorkflowTemplateDocument } from "./schemas/workflow.template.schema";

@Injectable()
export class WorkflowsService {
  constructor(@InjectModel('Workflow') private readonly workflowModel: Model<WorkflowDocument>,
    @InjectModel('WorkflowTemplate') private readonly workflowTemplateModel: Model<WorkflowTemplateDocument>) { }

  public async createWorkflow(templateId: string): Promise<IWorkflow> {
    if (!templateId) {
      throw new Error('Default workflow template is not defined');
    }
    const workflowTemplate = await this.workflowTemplateModel.findById(templateId);
    return await this.workflowModel.create({
      status: workflowTemplate.status,
      candidates: []
    });
  }

  public async getWorkflowById(id: string): Promise<IWorkflow> {
    return await this.workflowModel.findById(id);
  }

  public async removeWorkflowById(id: string) {
    return await this.workflowModel.findOneAndDelete({ _id: id });
  }

  public async updateWorkflowById(
    id: string,
    params: IWorkflow,
  ): Promise<IWorkflow> {
    return await this.workflowModel.findByIdAndUpdate({ _id: id }, params, { new: true, upsert: true });
  }
}