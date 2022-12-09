import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { IToken } from '../interfaces/token.interface';

export type TokenDocument = Token & Document;

@Schema()
export class Token implements IToken {
  @Prop({ required: true })
  user: string;

  @Prop({ required: true })
  token: string;
}

export const TokenSchema = SchemaFactory.createForClass(Token);