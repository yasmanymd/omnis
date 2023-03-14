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
  ): Promise<ResponseDto<IJob>> {
    const createJobResponse: IServiceResponse<IJob> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'job_create' }, jobRequest)
    );

    if (createJobResponse.status != HttpStatus.CREATED) {
      throw new HttpException({
        message: createJobResponse.message,
        data: null,
        errors: createJobResponse.errors,
      },
        createJobResponse.status);
    }
    return {
      message: createJobResponse.message,
      data: createJobResponse.data,
      errors: null
    };
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:job')
  @ApiOkResponse({
    type: ResponseDto<IJob[]>,
    description: 'List of jobs of user'
  })
  public async getJobs(): Promise<ResponseDto<IJob[]>> {
    const jobsResponse: IServiceResponse<IJob[]> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'jobs_list' }, {}),
    );

    return {
      message: jobsResponse.message,
      data: jobsResponse.data,
      errors: null,
    };
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
  ): Promise<ResponseDto<IJob>> {
    const jobResponse: IServiceResponse<IJob> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'job_search_by_id' }, id),
    );

    return {
      message: jobResponse.message,
      data: jobResponse.data,
      errors: null,
    };
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
  ): Promise<ResponseDto<null>> {
    const deleteJobResponse: IServiceResponse<null> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'job_delete_by_id' }, {
        id: id
      }),
    );

    if (deleteJobResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: deleteJobResponse.message,
          errors: deleteJobResponse.errors,
          data: null,
        },
        deleteJobResponse.status,
      );
    }

    return {
      message: deleteJobResponse.message,
      data: null,
      errors: null,
    };
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
  ): Promise<ResponseDto<IJob>> {
    const updateJobResponse: IServiceResponse<IJob> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'job_update_by_id' }, {
        id: id,
        user: req.user.email,
        job: jobRequest,
      }),
    );

    if (updateJobResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: updateJobResponse.message,
          errors: updateJobResponse.errors,
          data: null,
        },
        updateJobResponse.status,
      );
    }

    return {
      message: updateJobResponse.message,
      data: updateJobResponse.data,
      errors: null,
    };
  }
}
