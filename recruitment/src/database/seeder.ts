import { Injectable } from "@nestjs/common";
import { SettingsSeederService } from "./seeders/settings/settings.service";
import { WorkflowTemplatesSeederService } from "./seeders/workflowtemplates/workflow.templates.service";

@Injectable()
export class Seeder {
  constructor(
    private readonly workflowTemplatesSeederService: WorkflowTemplatesSeederService,
    private readonly settingsSeederService: SettingsSeederService,
  ) { }

  async seed() {
    await this.workflowTemplates().then(completed => Promise.resolve(completed)).catch(error => Promise.reject(error));
    await this.settings().then(completed => Promise.resolve(completed)).catch(error => Promise.reject(error));
  }

  async workflowTemplates() {
    return await Promise.all([this.workflowTemplatesSeederService.create()])
      .then(() => {
        return Promise.resolve(true);
      })
      .catch(error => Promise.reject(error));
  }

  async settings() {
    return await Promise.all([this.settingsSeederService.create()])
      .then(() => {
        return Promise.resolve(true);
      })
      .catch(error => Promise.reject(error));
  }

}