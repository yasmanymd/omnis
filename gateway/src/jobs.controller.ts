import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { CreateUpdateJobRequestDto } from './interfaces/jobs/dto/create-update-job-request.dto';
import { Observable } from 'rxjs';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { IJob } from './interfaces/jobs/job.interface';

@Controller('jobs')
export class JobsController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

  @Post()
  @ApiCreatedResponse({
    type: ResponseDto<IJob>
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:job')
  async createJob(
    @Body() jobRequest: CreateUpdateJobRequestDto
  ): Promise<Observable<ResponseDto<IJob>>> {
    return this.recruitmentService.send({ cmd: 'job_create' }, jobRequest);
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:job')
  @ApiOkResponse({
    type: ResponseDto<IJob[]>,
    description: 'List of jobs of user'
  })
  public async getJobs(): Promise<Observable<ResponseDto<IJob[]>>> {
    return this.recruitmentService.send({ cmd: 'jobs_list' }, {});
  }

  @Get(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:job')
  @ApiOkResponse({
    type: ResponseDto<IJob>,
    description: 'Job'
  })
  public async getJob(
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<IJob>>> {
    return this.recruitmentService.send({ cmd: 'job_search_by_id' }, id)
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:job')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete job'
  })
  public async deleteJob(
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<null>>> {
    return this.recruitmentService.send({ cmd: 'job_delete_by_id' }, { id: id });
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:job')
  @ApiOkResponse({
    type: ResponseDto<IJob>,
    description: 'Update job'
  })
  public async updateJob(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() jobRequest: CreateUpdateJobRequestDto,
  ): Promise<Observable<ResponseDto<IJob>>> {
    return this.recruitmentService.send({ cmd: 'job_update_by_id' }, {
      id: id,
      user: req.user.email,
      job: jobRequest,
    });
  }
}
