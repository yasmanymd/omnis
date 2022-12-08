import { NestFactory } from '@nestjs/core';
import { CandidateModule } from './candidates/candidates.module';
import { ConfigService } from './services/config/config.service';
import { Transport } from '@nestjs/microservices';

async function bootstrap() {
  const config = new ConfigService();
  const app = await NestFactory.createMicroservice(CandidateModule, {
    transport: Transport.RMQ,
    options: {
      urls: [config.get('rabbitmq_dsn')],
      queue: 'recruitment_queue',
      queueOptions: {
        durable: false
      },
    }
  });
  await app.listen();
}
bootstrap();
