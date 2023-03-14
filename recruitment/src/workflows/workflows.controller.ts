import { Controller, HttpStatus } from "@nestjs/common";
import { IWorkflow } from "./interfaces/workflow.interface";
import { WorkflowsService } from "./workflows.service";
import { MessagePattern } from '@nestjs/microservices';
import { IResponse } from "../common/response.interface";

@Controller()
export class WorkflowsController {
  constructor(private readonly workflowsService: WorkflowsService) { }

  @MessagePattern({ cmd: 'workflow_search_by_id' })
  public async workflowSearchById(id: string): Promise<IResponse<IWorkflow>> {
    let result: IResponse<IWorkflow>;

    const workflow = await this.workflowsService.getWorkflowById(id);
    result = {
      status: HttpStatus.OK,
      message: 'workflow_search_by_id_success',
      data: workflow
    };

    return result;
  }

  @MessagePattern({ cmd: 'workflow_create' })
  public async workflowCreate(workflow: IWorkflow): Promise<IResponse<IWorkflow>> {
    let result: IResponse<IWorkflow>;

    if (workflow) {
      try {
        const createdWorkflow = await this.workflowsService.createWorkflow(workflow);
        result = {
          status: HttpStatus.CREATED,
          message: 'workflow_create_success',
          data: createdWorkflow,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'workflow_create_precondition_failed',
          data: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'workflow_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'workflow_update_by_id' })
  public async workflowUpdateById(params: {
    workflow: IWorkflow;
    id: string;
    user: string;
  }): Promise<IResponse<IWorkflow>> {
    let result: IResponse<IWorkflow>;
    if (params.id) {
      try {
        const workflow = await this.workflowsService.getWorkflowById(params.id);
        if (workflow) {
          const updatedWorkflow = await this.workflowsService.updateWorkflowById(workflow._id, Object.assign(workflow, params.workflow));
          result = {
            status: HttpStatus.OK,
            message: 'workflow_update_by_id_success',
            data: updatedWorkflow,
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'workflow_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'workflow_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'workflow_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'workflow_delete_by_id' })
  public async workflowDeleteById(params: {
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.id) {
      try {
        const workflow = await this.workflowsService.getWorkflowById(params.id);

        if (workflow) {
          await this.workflowsService.removeWorkflowById(params.id);
          result = {
            status: HttpStatus.OK,
            message: 'workflow_delete_by_id_success',
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'workflow_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'workflow_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'workflow_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}