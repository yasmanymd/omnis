import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MongoConfigService } from '../../../services/config/mongo-config.service';
import { Settings, SettingsSchema } from '../../../settings/schemas/settings.schema';
import { SettingsSeederService } from './settings.service';

@Module({
  imports: [
    MongooseModule.forRootAsync({ useClass: MongoConfigService }),
    MongooseModule.forFeature([{ name: Settings.name, schema: SettingsSchema }])
  ],
  providers: [SettingsSeederService],
  exports: [SettingsSeederService],
})
export class SettingsSeederModule { }