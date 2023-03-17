import { Controller, HttpStatus } from "@nestjs/common";
import { IResponse } from "../common/response.interface";
import { IJob } from "./interfaces/job.interface";
import { JobsService } from "./jobs.service";
import { MessagePattern } from '@nestjs/microservices';
import { WorkflowsService } from "../workflows/workflows.service";
import { SettingsService } from "../settings/settings.service";

@Controller()
export class JobsController {
  constructor(private readonly jobService: JobsService,
    private readonly workflowsService: WorkflowsService,
    private readonly settingsService: SettingsService) { }

  @MessagePattern({ cmd: 'jobs_list' })
  public async jobsList(): Promise<IResponse<IJob[]>> {
    let result: IResponse<IJob[]>;

    const jobs = await this.jobService.getJobs();
    result = {
      status: HttpStatus.OK,
      message: 'jobs_list_success',
      data: jobs,
      errors: null
    };

    return result;
  }

  @MessagePattern({ cmd: 'job_search_by_id' })
  public async jobSearchById(id: string): Promise<IResponse<IJob>> {
    let result: IResponse<IJob>;

    const job = await this.jobService.getJobById(id);
    result = {
      status: HttpStatus.OK,
      message: 'job_search_by_id_success',
      data: job
    };

    return result;
  }

  @MessagePattern({ cmd: 'job_create' })
  public async jobCreate(job: IJob): Promise<IResponse<IJob>> {
    let result: IResponse<IJob>;

    if (job) {
      try {
        const settings = await this.settingsService.getSettings();
        const workflow = await this.workflowsService.createWorkflow(settings.default_workflow_template_id);
        job.workflow_id = workflow._id;
        const createdJob = await this.jobService.createJob(job);
        result = {
          status: HttpStatus.CREATED,
          message: 'job_create_success',
          data: createdJob,
          errors: null
        };
      } catch (err) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'job_create_precondition_failed',
          data: null,
          errors: [{ message: err.message }]
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'job_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'job_update_by_id' })
  public async jobUpdateById(params: {
    job: IJob;
    id: string;
  }): Promise<IResponse<IJob>> {
    let result: IResponse<IJob>;
    if (params.id) {
      try {
        const job = await this.jobService.getJobById(params.id);
        if (job) {
          const updatedJob = await this.jobService.updateJobById(job._id, params.job);
          result = {
            status: HttpStatus.OK,
            message: 'job_update_by_id_success',
            data: updatedJob,
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'job_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'job_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'job_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'job_delete_by_id' })
  public async jobDeleteById(params: {
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.id) {
      try {
        const job = await this.jobService.getJobById(params.id);

        if (job) {
          await this.jobService.removeJobById(params.id);
          result = {
            status: HttpStatus.OK,
            message: 'job_delete_by_id_success',
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'job_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'job_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'job_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}