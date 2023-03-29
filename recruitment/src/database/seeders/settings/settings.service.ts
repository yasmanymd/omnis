import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { SettingsDocument } from "../../../settings/schemas/settings.schema";

@Injectable()
export class SettingsSeederService {
  constructor(@InjectModel('Settings') private readonly settingsModel: Model<SettingsDocument>) { }

  async create(): Promise<boolean> {
    const result = await this.settingsModel.findById('64137d10844f44f9009f1736').exec();
    if (!result) {
      await this.settingsModel.create({
        _id: '64137d10844f44f9009f1736',
        default_workflow_template_id: '6413ae26bf739f1ffb52f6ed',
        __v: 0
      })
    }
    return true;
  }
}