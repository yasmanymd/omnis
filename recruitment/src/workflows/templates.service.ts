import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IWorkflowTemplate } from "./interfaces/workflow.template.interface";
import { WorkflowTemplateDocument } from "./schemas/workflow.template.schema";

@Injectable()
export class WorkflowTemplatesService {
  constructor(@InjectModel('WorkflowTemplate') private readonly workflowTemplateModel: Model<WorkflowTemplateDocument>) { }

  public async createTemplate(workflowTemplate: IWorkflowTemplate): Promise<IWorkflowTemplate> {
    delete workflowTemplate._id;
    return await this.workflowTemplateModel.create(workflowTemplate);
  }

  public async getTemplateById(id: string): Promise<IWorkflowTemplate> {
    return await this.workflowTemplateModel.findById(id);
  }

  public async removeTemplateById(id: string) {
    return await this.workflowTemplateModel.findOneAndDelete({ _id: id });
  }

  public async updateTemplateById(
    id: string,
    params: IWorkflowTemplate,
  ): Promise<IWorkflowTemplate> {
    return await this.workflowTemplateModel.findByIdAndUpdate({ _id: id }, params, { new: true, upsert: true });
  }
}