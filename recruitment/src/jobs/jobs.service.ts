import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IJob } from "./interfaces/job.interface";
import { JobDocument } from "./schemas/job.schema";

@Injectable()
export class JobsService {
  constructor(@InjectModel('Job') private readonly jobModel: Model<JobDocument>) { }

  public async createJob(job: IJob): Promise<IJob> {
    return await this.jobModel.create(job);
  }

  public async getJobs(): Promise<IJob[]> {
    return this.jobModel.find({});
  }

  public async getJobById(id: string): Promise<IJob> {
    return await this.jobModel.findById(id);
  }

  public async removeJobById(id: string) {
    return await this.jobModel.findOneAndDelete({ _id: id });
  }

  public async updateJobById(
    id: string,
    params: IJob,
  ): Promise<IJob> {
    return await this.jobModel.findByIdAndUpdate({ _id: id }, params, { new: true, upsert: true });
  }
}