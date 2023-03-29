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
            name: 'Init',
            type: 'init'
          },
          {
            name: 'In progress'
          },
          {
            name: 'Done',
            type: 'end'
          }
        ]
      })
    }
    return true;
  }
}