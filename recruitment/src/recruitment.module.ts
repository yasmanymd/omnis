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
import { Workflow, WorkflowSchema } from './workflows/schemas/workflow.schema';
import { WorkflowsController } from './workflows/workflows.controller';
import { WorkflowsService } from './workflows/workflows.service';
import { WorkflowTemplate, WorkflowTemplateSchema } from './workflows/schemas/workflow.template.schema';
import { WorkflowTemplatesController } from './workflows/templates.controller';
import { WorkflowTemplatesService } from './workflows/templates.service';

@Module({
  imports: [
    MongooseModule.forRootAsync({ useClass: MongoConfigService }),
    MongooseModule.forFeature([{ name: Candidate.name, schema: CandidateSchema }]),
    MongooseModule.forFeature([{ name: Note.name, schema: NoteSchema }]),
    MongooseModule.forFeature([{ name: Workflow.name, schema: WorkflowSchema }]),
    MongooseModule.forFeature([{ name: WorkflowTemplate.name, schema: WorkflowTemplateSchema }]),
    MongooseModule.forFeature([{ name: Client.name, schema: ClientSchema }]),
    MongooseModule.forFeature([{ name: Job.name, schema: JobSchema }]),
    MongooseModule.forFeature([{ name: Token.name, schema: TokenSchema }])
  ],
  controllers: [CandidatesController, NotesController, WorkflowsController, WorkflowTemplatesController, TokenController, JobsController, ClientsController],
  providers: [CandidatesService, NotesService, WorkflowsService, WorkflowTemplatesService, TokenService, JobsService, ClientsService],
})
export class RecruimentModule { }