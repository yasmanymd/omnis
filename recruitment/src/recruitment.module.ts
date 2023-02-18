import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MongoConfigService } from './services/config/mongo-config.service';
import { Token, TokenSchema } from './token/schemas/token.schema';
import { TokenService } from './token/token.service';
import { CandidatesController } from './candidates/candidates.controller';
import { CandidatesService } from './candidates/candidates.service';
import { Candidate, CandidateSchema } from './candidates/schemas/candidate.schema';
import { Note, NoteSchema } from './notes/schemas/note.schema';
import { TokenController } from './token/token.controller';
import { NotesController } from './notes/notes.controller';
import { NotesService } from './notes/notes.service';
import { Client, ClientSchema } from './clients/schemas/client.schema';
import { Job, JobSchema } from './jobs/schemas/job.schema';
import { JobsController } from './jobs/jobs.controller';
import { ClientsController } from './clients/clients.controller';
import { JobsService } from './jobs/jobs.service';
import { ClientsService } from './clients/clients.service';

@Module({
  imports: [
    MongooseModule.forRootAsync({ useClass: MongoConfigService }),
    MongooseModule.forFeature([{ name: Candidate.name, schema: CandidateSchema }]),
    MongooseModule.forFeature([{ name: Note.name, schema: NoteSchema }]),
    MongooseModule.forFeature([{ name: Client.name, schema: ClientSchema }]),
    MongooseModule.forFeature([{ name: Job.name, schema: JobSchema }]),
    MongooseModule.forFeature([{ name: Token.name, schema: TokenSchema }])
  ],
  controllers: [CandidatesController, NotesController, TokenController, JobsController, ClientsController],
  providers: [CandidatesService, NotesService, TokenService, JobsService, ClientsService],
})
export class RecruimentModule { }