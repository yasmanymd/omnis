import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceResponse } from './interfaces/common/service-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { CreateNoteRequestDto } from './interfaces/notes/dto/create-note-request.dto';
import { UpdateNoteRequestDto } from './interfaces/notes/dto/update-note-request.dto';
import { INote } from './interfaces/notes/note.interface';

@Controller('notes')
export class NotesController {
  constructor(@Inject('NOTE_SERVICE') private readonly noteService: ClientProxy) { }

  @Post()
  @ApiCreatedResponse({
    type: ResponseDto<INote>
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:note')
  async createNote(
    @Req() req: { user: IUser },
    @Body() noteRequest: CreateNoteRequestDto
  ): Promise<ResponseDto<INote>> {
    const createNoteResponse: IServiceResponse<INote> = await firstValueFrom(
      this.noteService.send({ cmd: 'note_create' },
        {
          ...noteRequest,
          created_by: req.user.email
        }
      )
    );

    if (createNoteResponse.status != HttpStatus.CREATED) {
      throw new HttpException({
        message: createNoteResponse.message,
        data: null,
        errors: createNoteResponse.errors,
      },
        createNoteResponse.status);
    }
    return {
      message: createNoteResponse.message,
      data: createNoteResponse.data,
      errors: null
    };
  }

  @Get('/search?')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:note')
  @ApiOkResponse({
    type: ResponseDto<INote[]>,
    description: 'List of notes of candidate'
  })
  public async getNotes(
    @Query('candidate_id') candidate_id: string
  ): Promise<ResponseDto<INote[]>> {
    const notesResponse: IServiceResponse<INote[]> = await firstValueFrom(
      this.noteService.send({ cmd: 'notes_search_by_candidate' }, candidate_id),
    );

    return {
      message: notesResponse.message,
      data: notesResponse.data,
      errors: null,
    };
  }

  @Get(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:note')
  @ApiOkResponse({
    type: ResponseDto<INote>,
    description: 'Note'
  })
  public async getNote(
    @Param('id') id: string,
  ): Promise<ResponseDto<INote>> {
    const noteResponse: IServiceResponse<INote> = await firstValueFrom(
      this.noteService.send({ cmd: 'note_search_by_id' }, id),
    );

    return {
      message: noteResponse.message,
      data: noteResponse.data,
      errors: null,
    };
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:note')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete note'
  })
  public async deleteNote(
    @Req() req: { user: IUser },
    @Param('id') id: string,
  ): Promise<ResponseDto<null>> {
    const deleteNoteResponse: IServiceResponse<null> = await firstValueFrom(
      this.noteService.send({ cmd: 'note_delete_by_id' }, {
        id: id,
        user: req.user.email
      }),
    );

    if (deleteNoteResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: deleteNoteResponse.message,
          errors: deleteNoteResponse.errors,
          data: null,
        },
        deleteNoteResponse.status,
      );
    }

    return {
      message: deleteNoteResponse.message,
      data: null,
      errors: null,
    };
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:note')
  @ApiOkResponse({
    type: ResponseDto<INote>,
    description: 'Update note'
  })
  public async updateNote(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() noteRequest: UpdateNoteRequestDto,
  ): Promise<ResponseDto<INote>> {
    const updateNoteResponse: IServiceResponse<INote> = await firstValueFrom(
      this.noteService.send({ cmd: 'note_update_by_id' }, {
        id: id,
        user: req.user.email,
        note: { ...noteRequest, modified_by: req.user.email },
      }),
    );

    if (updateNoteResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: updateNoteResponse.message,
          errors: updateNoteResponse.errors,
          data: null,
        },
        updateNoteResponse.status,
      );
    }

    return {
      message: updateNoteResponse.message,
      data: updateNoteResponse.data,
      errors: null,
    };
  }
}
