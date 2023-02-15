import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { ICandidate } from "./interfaces/candidate.interface";
import { CandidateDocument } from "./schemas/candidate.schema";

@Injectable()
export class CandidatesService {
  constructor(@InjectModel('Candidate') private readonly candidateModel: Model<CandidateDocument>) { }

  public async createCandidate(candidate: ICandidate): Promise<ICandidate> {
    let data = await this.candidateModel.exists({ "contacts.linkedin": candidate.contacts.linkedin }).exec();
    if (data) {
      return;
    }
    return await this.candidateModel.findOneAndUpdate({ "contacts.linkedin": candidate.contacts.linkedin }, candidate, { new: true, upsert: true });
  }

  public async getCandidates(): Promise<ICandidate[]> {
    return this.candidateModel.find({}, [], { sort: { created_at: -1 } }).exec();
  }

  public async getCandidatesByUser(user: string): Promise<ICandidate[]> {
    return this.candidateModel.find({ created_by: user }).exec();
  }

  public async getCandidateById(id: string): Promise<ICandidate> {
    return await this.candidateModel.findById(id);
  }

  public async removeCandidateById(id: string) {
    return await this.candidateModel.findOneAndDelete({ _id: id });
  }

  public async updateCandidateById(
    id: string,
    params: ICandidate,
  ): Promise<ICandidate> {
    return await this.candidateModel.findByIdAndUpdate({ _id: id }, params, { new: true, upsert: true });
  }
}