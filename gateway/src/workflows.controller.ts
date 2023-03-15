import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { CreateUpdateJobRequestDto } from './interfaces/jobs/dto/create-update-job-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceResponse } from './interfaces/common/service-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { IWorkflowTemplate } from './interfaces/workflows/workflow.template.interface';

@Controller('workflows')
export class WorkflowsController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

  @Get('templates')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:workflow')
  @ApiOkResponse({
    type: ResponseDto<IWorkflowTemplate[]>,
    description: 'List of workflows templates'
  })
  public async getWorkflowTemplates(): Promise<ResponseDto<IWorkflowTemplate[]>> {
    const workflowTemplatesResponse: IServiceResponse<IWorkflowTemplate[]> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'workflow_templates_get' }, {}),
    );

    return {
      message: workflowTemplatesResponse.message,
      data: workflowTemplatesResponse.data,
      errors: null,
    };
  }
}
