import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { ISettings } from "./interfaces/settings.interface";
import { SettingsDocument } from "./schemas/settings.schema";

@Injectable()
export class SettingsService {
  constructor(@InjectModel('Settings') private readonly settingsModel: Model<SettingsDocument>) { }

  public async updateSettings(settings: ISettings): Promise<ISettings> {
    return await this.settingsModel.findOneAndUpdate({}, settings, { new: true, upsert: true })
  }

  public async getSettings(): Promise<ISettings> {
    const result = await this.settingsModel.findOne({});
    if (!result) {
      return await this.settingsModel.create({});
    }
    return result;
  }
}