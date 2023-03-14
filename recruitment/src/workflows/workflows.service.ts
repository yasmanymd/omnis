import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IWorkflow } from "./interfaces/workflow.interface";
import { WorkflowDocument } from "./schemas/workflow.schema";

@Injectable()
export class WorkflowsService {
  constructor(@InjectModel('Workflow') private readonly workflowModel: Model<WorkflowDocument>) { }

  public async createWorkflow(workflow: IWorkflow): Promise<IWorkflow> {
    delete workflow._id;
    return await this.workflowModel.create(workflow);
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