import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { Observable } from 'rxjs';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { CreateNoteRequestDto } from './interfaces/notes/dto/create-note-request.dto';
import { UpdateNoteRequestDto } from './interfaces/notes/dto/update-note-request.dto';
import { INote } from './interfaces/notes/note.interface';

@Controller('notes')
export class NotesController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

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
  ): Promise<Observable<ResponseDto<INote>>> {
    return this.recruitmentService.send({ cmd: 'note_create' },
      {
        ...noteRequest,
        created_by: req.user.email,
        modified_by: req.user.email
      }
    );
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
  ): Promise<Observable<ResponseDto<INote[]>>> {
    return this.recruitmentService.send({ cmd: 'notes_search_by_candidate' }, candidate_id);
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
  ): Promise<Observable<ResponseDto<INote>>> {
    return this.recruitmentService.send({ cmd: 'note_search_by_id' }, id);
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
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<null>>> {
    return this.recruitmentService.send({ cmd: 'note_delete_by_id' }, {
      id: id
    });
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
  ): Promise<Observable<ResponseDto<INote>>> {
    return this.recruitmentService.send({ cmd: 'note_update_by_id' }, {
      id: id,
      user: req.user.email,
      note: {
        ...noteRequest,
        modified_by: req.user.email,
        modified_at: +new Date()
      },
    });
  }
}
