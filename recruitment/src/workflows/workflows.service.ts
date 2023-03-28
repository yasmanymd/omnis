import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { CandidateDocument } from "../candidates/schemas/candidate.schema";
import { IWorkflow } from "./interfaces/workflow.interface";
import { WorkflowDocument } from "./schemas/workflow.schema";
import { WorkflowTemplateDocument } from "./schemas/workflow.template.schema";

@Injectable()
export class WorkflowsService {
  constructor(@InjectModel('Workflow') private readonly workflowModel: Model<WorkflowDocument>,
    @InjectModel('WorkflowTemplate') private readonly workflowTemplateModel: Model<WorkflowTemplateDocument>,
    @InjectModel('Candidate') private readonly candidateModel: Model<CandidateDocument>) { }

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

  public async assignCandidates(workflow_id: string, candidates: string[]) {
    let workflow = await this.workflowModel.findById(workflow_id);
    const { name: initStatus } = workflow.status.find(item => item.type === 'init');
    for (let i = 0; i < candidates.length; i++) {
      const candidateId = candidates[i];
      if (workflow.candidates.findIndex(c => c.candidate_id === candidateId) === -1) {
        const candidate = await this.candidateModel.findById(candidateId).exec();
        workflow.candidates.push({
          candidate_id: candidateId,
          name: candidate.name,
          status: initStatus,
          modified_date: +new Date()
        });
      }
    }

    await workflow.save();
    return true;
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