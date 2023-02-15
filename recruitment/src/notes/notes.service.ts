import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { INote } from "./interfaces/note.interface";
import { NoteDocument } from "./schemas/note.schema";

@Injectable()
export class NotesService {
  constructor(@InjectModel('Note') private readonly noteModel: Model<NoteDocument>) { }

  public async createNote(note: INote): Promise<INote> {
    delete note._id;
    return await this.noteModel.create(note);
  }

  public async getNotesByCandidate(candidate_id: string): Promise<INote[]> {
    return this.noteModel.find({ candidate_id: candidate_id }, [], { sort: { 'created_at': -1 } }).exec();
  }

  public async getNoteById(id: string): Promise<INote> {
    return await this.noteModel.findById(id);
  }

  public async removeNoteById(id: string) {
    return await this.noteModel.findOneAndDelete({ _id: id });
  }

  public async updateNoteById(
    id: string,
    params: INote,
  ): Promise<INote> {
    return await this.noteModel.findByIdAndUpdate({ _id: id }, params, { new: true, upsert: true });
  }
}