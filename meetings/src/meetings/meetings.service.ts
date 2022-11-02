import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IMeetingUpdateParams } from "./interfaces/meeting-update-params.interface";
import { IMeeting } from "./interfaces/meeting.interface";

@Injectable()
export class MeetingsService {
  constructor(@InjectModel('Meeting') private readonly meetingModel: Model<IMeeting>) {}

  public async createMeeting(meeting: IMeeting): Promise<IMeeting> {
    const meetingModel = new this.meetingModel(meeting);
    return await meetingModel.save();
  }

  public async getMeetingsByUser(user: string): Promise<IMeeting[]> {
    return this.meetingModel.find({ created_by: user }).exec();
  }

  public async getMeetingById(id: string) {
    return await this.meetingModel.findById(id);
  }

  public async removeMeetingById(id: string) {
    return await this.meetingModel.findOneAndDelete({ _id: id });
  }

  /*public async updateMeetingById(
    id: string,
    params: IMeetingUpdateParams,
  ): Promise<IMeeting> {
    return await this.meetingModel.updateOne({ _id: id }, params);
  }*/
}