import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IMeeting } from "./interfaces/meeting.interface";

@Injectable()
export class MeetingsService {
  constructor(@InjectModel('Meeting') private readonly meetingModel: Model<IMeeting>) {}

  public async createMeeting(meeting: IMeeting): Promise<IMeeting> {
    const meetingModel = new this.meetingModel(meeting);
    return await meetingModel.save();
  }
}