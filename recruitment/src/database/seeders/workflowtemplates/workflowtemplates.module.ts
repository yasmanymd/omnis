import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MongoConfigService } from '../../../services/config/mongo-config.service';
import { WorkflowTemplate, WorkflowTemplateSchema } from '../../../workflows/schemas/workflow.template.schema';
import { WorkflowTemplatesSeederService } from './workflow.templates.service';

@Module({
  imports: [
    MongooseModule.forRootAsync({ useClass: MongoConfigService }),
    MongooseModule.forFeature([{ name: WorkflowTemplate.name, schema: WorkflowTemplateSchema }])
  ],
  providers: [WorkflowTemplatesSeederService],
  exports: [WorkflowTemplatesSeederService],
})
export class WorkflowTemplatesSeederModule { }