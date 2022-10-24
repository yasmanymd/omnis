import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MongoConfigService } from '../services/config/mongo-config.service';
import { MeetingsController } from './meetings.controller';
import { MeetingsService } from './meetings.service';
import { Meeting, MeetingSchema } from './schemas/meeting.schema';

@Module({
  imports: [
    MongooseModule.forRootAsync({useClass: MongoConfigService}),
    MongooseModule.forFeature([{ name: Meeting.name, schema: MeetingSchema }])
  ],
  controllers: [MeetingsController],
  providers: [MeetingsService],
})
export class MeetingModule {}