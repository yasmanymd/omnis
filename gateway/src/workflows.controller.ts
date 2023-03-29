import { Body, Controller, Get, Inject, Param, Post, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { Observable } from 'rxjs';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IWorkflowTemplate } from './interfaces/workflows/workflow.template.interface';
import { IWorkflow } from './interfaces/workflows/workflow.interface';
import { ChangeCandidateStatusRequestDto } from './interfaces/workflows/dto/change-candidate-status-request.dto';

@Controller('workflows')
export class WorkflowsController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

  @Get(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:workflow')
  @ApiOkResponse({
    type: ResponseDto<IWorkflow>,
    description: 'Workflow'
  })
  public async getWorkflow(
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<IWorkflow>>> {
    return this.recruitmentService.send({ cmd: 'workflow_search_by_id' }, id);
  }

  @Get('templates')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:workflow')
  @ApiOkResponse({
    type: ResponseDto<IWorkflowTemplate[]>,
    description: 'List of workflows templates'
  })
  public async getWorkflowTemplates(): Promise<Observable<ResponseDto<IWorkflowTemplate[]>>> {
    return this.recruitmentService.send({ cmd: 'workflow_templates_get' }, {});
  }

  @Post(':id/change-candidate-status')
  @ApiOkResponse({
    type: ResponseDto<null>
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:workflow')
  async changeCandidateStatus(
    @Param('id') workflowId: string,
    @Body() changeCandidateStatusRequest: ChangeCandidateStatusRequestDto
  ): Promise<Observable<ResponseDto<null>>> {
    return this.recruitmentService.send({ cmd: 'workflow_change_candidate_status' }, { ...changeCandidateStatusRequest, workflowId });
  }
}
