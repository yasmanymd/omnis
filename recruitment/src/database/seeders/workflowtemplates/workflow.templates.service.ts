import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { WorkflowTemplateDocument } from "../../../workflows/schemas/workflow.template.schema";

@Injectable()
export class WorkflowTemplatesSeederService {
  constructor(@InjectModel('WorkflowTemplate') private readonly workflowTemplateModel: Model<WorkflowTemplateDocument>) { }

  async create(): Promise<boolean> {
    const result = await this.workflowTemplateModel.findById('6413ae26bf739f1ffb52f6ed').exec();
    if (!result) {
      await this.workflowTemplateModel.create({
        _id: '6413ae26bf739f1ffb52f6ed',
        name: 'Recruitment Workflow',
        status: [
          {
            name: 'Pipeline',
            type: 'init'
          },
          {
            name: 'Wrong Target'
          },
          {
            name: 'Reached out'
          },
          {
            name: 'No Go'
          },
          {
            name: 'Relance'
          },
          {
            name: 'No Go/Relance'
          },
          {
            name: 'Relance 2'
          },
          {
            name: 'No Go/Relance 2'
          },
          {
            name: 'Evaluation'
          },
          {
            name: 'No fit'
          },
          {
            name: 'Depot'
          },
          {
            name: 'Client Interview'
          },
          {
            name: 'Inconclusive'
          },
          {
            name: 'Reference Check'
          },
          {
            name: 'Offer'
          },
          {
            name: 'Hired'
          },
          {
            name: 'Refused'
          }
        ]
      })
    }
    return true;
  }
}