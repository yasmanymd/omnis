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

  @MessagePattern({ cmd: 'workflow_change_candidate_status' })
  public async changeCandidateStatus(params: {
    workflowId: string,
    candidateId: string,
    status: string
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    await this.workflowsService.changeCandidateStatus(params.workflowId, params.candidateId, params.status);

    result = {
      status: HttpStatus.OK,
      message: 'workflow_change_candidate_status_success',
      data: null
    };

    return result;
  }
}