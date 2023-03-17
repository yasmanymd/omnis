import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { ISettings } from '../interfaces/settings.interface';

export type SettingsDocument = Settings & Document;

@Schema({ strict: false })
export class Settings implements ISettings {
  [key: string]: string;
}

export const SettingsSchema = SchemaFactory.createForClass(Settings);