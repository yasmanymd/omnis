import {
  MongooseOptionsFactory,
  MongooseModuleOptions,
} from '@nestjs/mongoose';
  
export class MongoConfigService implements MongooseOptionsFactory {  
  createMongooseOptions(): MongooseModuleOptions {
    return {
      dbName: 'meetings',
      uri: process.env.MONGO_DSN
    };
  }
}