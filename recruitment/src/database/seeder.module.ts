import { Module } from "@nestjs/common";
import { Seeder } from "./seeder";
import { SettingsSeederModule } from "./seeders/settings/settings.module";
import { WorkflowTemplatesSeederModule } from "./seeders/workflowtemplates/workflowtemplates.module";

@Module({
  imports: [WorkflowTemplatesSeederModule, SettingsSeederModule],
  providers: [Seeder],
})
export class SeederModule { }