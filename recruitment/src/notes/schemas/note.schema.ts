import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from "mongoose";
import { INote } from '../interfaces/note.interface';

export type NoteDocument = Note & Document;

@Schema({ strict: false })
export class Note implements INote {
  _id: string;

  @Prop({ required: true })
  note: string;

  @Prop({ required: true })
  candidate_id: string;

  @Prop({ required: true })
  created_at: number;

  @Prop({ required: true })
  created_by: string;

  @Prop({ required: true })
  modified_by: string;

  @Prop({ required: true })
  modified_at: number;
}

export const NoteSchema = SchemaFactory.createForClass(Note);