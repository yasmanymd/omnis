import { Controller, HttpStatus } from "@nestjs/common";
import { IWorkflowTemplate } from "./interfaces/workflow.template.interface";
import { WorkflowTemplatesService } from "./templates.service";
import { MessagePattern } from '@nestjs/microservices';
import { IResponse } from "../common/response.interface";

@Controller()
export class WorkflowTemplatesController {
  constructor(private readonly workflowTemplatesService: WorkflowTemplatesService) { }

  @MessagePattern({ cmd: 'workflow_templates_get' })
  public async getTemplates(): Promise<IResponse<IWorkflowTemplate[]>> {
    let result: IResponse<IWorkflowTemplate[]>;

    const templates = await this.workflowTemplatesService.getTemplates();
    result = {
      status: HttpStatus.OK,
      message: 'workflow_templates_get_success',
      data: templates
    };

    return result;
  }

  @MessagePattern({ cmd: 'workflow_template_search_by_id' })
  public async templatesSearchById(id: string): Promise<IResponse<IWorkflowTemplate>> {
    let result: IResponse<IWorkflowTemplate>;

    const template = await this.workflowTemplatesService.getTemplateById(id);
    result = {
      status: HttpStatus.OK,
      message: 'workflow_template_search_by_id_success',
      data: template
    };

    return result;
  }

  @MessagePattern({ cmd: 'workflow_template_create' })
  public async templateCreate(template: IWorkflowTemplate): Promise<IResponse<IWorkflowTemplate>> {
    let result: IResponse<IWorkflowTemplate>;

    if (template) {
      try {
        const createdTemplate = await this.workflowTemplatesService.createTemplate(template);
        result = {
          status: HttpStatus.CREATED,
          message: 'workflow_template_create_success',
          data: createdTemplate,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'workflow_template_create_precondition_failed',
          data: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'workflow_template_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'workflow_template_update_by_id' })
  public async templateUpdateById(params: {
    template: IWorkflowTemplate;
    id: string;
    user: string;
  }): Promise<IResponse<IWorkflowTemplate>> {
    let result: IResponse<IWorkflowTemplate>;
    if (params.id) {
      try {
        const template = await this.workflowTemplatesService.getTemplateById(params.id);
        if (template) {
          const updatedTemplate = await this.workflowTemplatesService.updateTemplateById(template._id, Object.assign(template, params.template));
          result = {
            status: HttpStatus.OK,
            message: 'workflow_template_update_by_id_success',
            data: updatedTemplate,
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'workflow_template_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'workflow_template_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'workflow_template_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'workflow_template_delete_by_id' })
  public async templateDeleteById(params: {
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.id) {
      try {
        const template = await this.workflowTemplatesService.getTemplateById(params.id);

        if (template) {
          await this.workflowTemplatesService.removeTemplateById(params.id);
          result = {
            status: HttpStatus.OK,
            message: 'workflow_template_delete_by_id_success',
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'workflow_template_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'workflow_template_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'workflow_template_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}