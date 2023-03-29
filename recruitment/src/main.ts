import { NestFactory } from '@nestjs/core';
import { RecruimentModule } from './recruitment.module';
import { ConfigService } from './services/config/config.service';
import { Transport } from '@nestjs/microservices';
import { SeederModule } from './database/seeder.module';
import { Seeder } from './database/seeder';

async function bootstrap() {
  const config = new ConfigService();
  NestFactory.createApplicationContext(SeederModule)
    .then(appContext => {
      const seeder = appContext.get(Seeder)
      seeder
        .seed()
        .then(() => {
          console.log('Seeding complete!');
        })
        .catch(error => {
          console.log('Seeding failed!');
        })
        .finally(() => appContext.close());
    })
    .catch(error => {
      throw error;
    });
  const app = await NestFactory.createMicroservice(RecruimentModule, {
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
