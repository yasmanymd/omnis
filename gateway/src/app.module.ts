import { Module } from '@nestjs/common';
import { MeetingsController } from './meetings.controller';
import { ClientsModule } from '@nestjs/microservices';
import { Transport } from '@nestjs/microservices';
import { ConfigService } from './config/config.service';
import { ConfigModule } from './config/config.module';
import { AuthzModule } from './authz/authz.module';
import { CandidatesController } from './candidates.controller';
import { TokenController } from './token.controller';
import { NotesController } from './notes.controller';
import { JobsController } from './jobs.controller';
import { ClientsController } from './clients.controller';
import { WorkflowsController } from './workflows.controller';

@Module({
  imports: [
    ConfigModule,
    ClientsModule.registerAsync([
      {
        name: 'MEETING_SERVICE',
        imports: [ConfigModule],
        useFactory: async (configService: ConfigService) => {
          return ({
            transport: Transport.RMQ,
            options: {
              urls: [configService.get('rabbitmq_dsn')],
              queue: 'meetings_queue',
              queueOptions: {
                durable: false
              },
            }
          });
        },
        inject: [ConfigService]
      }
    ]),
    ClientsModule.registerAsync([
      {
        name: 'RECRUITMENT_SERVICE',
        imports: [ConfigModule],
        useFactory: async (configService: ConfigService) => {
          return ({
            transport: Transport.RMQ,
            options: {
              urls: [configService.get('rabbitmq_dsn')],
              queue: 'recruitment_queue',
              queueOptions: {
                durable: false
              },
            }
          });
        },
        inject: [ConfigService]
      }
    ]),
    AuthzModule
  ],
  controllers: [MeetingsController, CandidatesController, NotesController, TokenController, JobsController, ClientsController, WorkflowsController],
  providers: [],
})
export class AppModule { }
