import { Controller, HttpStatus } from "@nestjs/common";
import { INote } from "./interfaces/note.interface";
import { NotesService } from "./notes.service";
import { MessagePattern } from '@nestjs/microservices';
import { IResponse } from "../common/response.interface";

@Controller()
export class NotesController {
  constructor(private readonly notesService: NotesService) { }

  @MessagePattern({ cmd: 'note_search_by_id' })
  public async noteSearchById(id: string): Promise<IResponse<INote>> {
    let result: IResponse<INote>;

    const note = await this.notesService.getNoteById(id);
    result = {
      status: HttpStatus.OK,
      message: 'note_search_by_id_success',
      data: note
    };

    return result;
  }

  @MessagePattern({ cmd: 'notes_search_by_candidate' })
  public async notesSearchByUser(candidate_id: string): Promise<IResponse<INote[]>> {
    let result: IResponse<INote[]>;

    if (candidate_id) {
      const notes = await this.notesService.getNotesByCandidate(candidate_id);
      result = {
        status: HttpStatus.OK,
        message: 'notes_search_by_candidate_success',
        data: notes
      };
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'notes_search_by_candidate_bad_request',
        data: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'note_create' })
  public async noteCreate(note: INote): Promise<IResponse<INote>> {
    let result: IResponse<INote>;

    if (note) {
      try {
        const createdNote = await this.notesService.createNote(
          Object.assign(note, {
            created_at: +new Date(),
            modified_at: +new Date()
          })
        );
        result = {
          status: HttpStatus.CREATED,
          message: 'note_create_success',
          data: createdNote,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'note_create_precondition_failed',
          data: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'note_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'note_update_by_id' })
  public async noteUpdateById(params: {
    note: INote;
    id: string;
    user: string;
  }): Promise<IResponse<INote>> {
    let result: IResponse<INote>;
    if (params.id) {
      try {
        const note = await this.notesService.getNoteById(params.id);
        if (note) {
          const updatedNote = await this.notesService.updateNoteById(note._id, Object.assign(note, params.note));
          result = {
            status: HttpStatus.OK,
            message: 'note_update_by_id_success',
            data: updatedNote,
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'note_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'note_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'note_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'note_delete_by_id' })
  public async noteDeleteForUser(params: {
    user: string;
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.user && params.id) {
      try {
        const note = await this.notesService.getNoteById(params.id);

        if (note) {
          await this.notesService.removeNoteById(params.id);
          result = {
            status: HttpStatus.OK,
            message: 'note_delete_by_id_success',
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'note_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'note_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'note_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}