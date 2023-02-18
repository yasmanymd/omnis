import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { IClient } from '../interfaces/client.interface';

export type ClientDocument = Client & Document;

@Schema({ strict: false })
export class Client implements IClient {
  _id: string;

  @Prop({ required: true })
  name: string;

  @Prop({ required: false })
  description: string;

  contacts: { [key: string]: any };
}

export const ClientSchema = SchemaFactory.createForClass(Client);