import { NestFactory } from '@nestjs/core';
import { MeetingModule } from './meetings/meetings.module';
import { ConfigService } from './services/config/config.service';
import { Transport } from '@nestjs/microservices';

async function bootstrap() {
  const config = new ConfigService();
  const app = await NestFactory.createMicroservice(MeetingModule, { 
    transport: Transport.RMQ,
    options: {
      urls: [config.get('rabbitmq_dsn')],
      queue: 'meetings_queue',
      queueOptions: {
        durable: false
      },
    }
  });
  await app.listen();
}
bootstrap();
