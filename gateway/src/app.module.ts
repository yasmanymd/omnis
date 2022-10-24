import { Module } from '@nestjs/common';
import { MeetingsController } from './meetings.controller';
import { ClientsModule } from '@nestjs/microservices';
import { Transport } from '@nestjs/microservices';
import { ConfigService } from './config/config.service';
import { ConfigModule } from './config/config.module';
import { AuthzModule } from './authz/authz.module';

@Module({
  imports: [
    ConfigModule,
    ClientsModule.registerAsync([
      { 
        name: 'MEETING_SERVICE', 
        imports: [ConfigModule],
        useFactory: async (configService: ConfigService) => {
          console.log('init: ' + configService.get('rabbitmq_dsn'));
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
    AuthzModule
  ],
  controllers: [MeetingsController],
  providers: [],
})
export class AppModule {}
