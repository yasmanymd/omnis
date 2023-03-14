import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { CreateCandidateRequestDto } from './interfaces/candidates/dto/create-candidate-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceResponse } from './interfaces/common/service-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { UpdateCandidateRequestDto } from './interfaces/candidates/dto/update-candidate-request.dto';
import { ImportCandidateRequestDto } from './interfaces/candidates/dto/import-candidate-request.dto';
import { ICandidate } from './interfaces/candidates/candidate.interface';

@Controller('candidates')
export class CandidatesController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

  @Post()
  @ApiCreatedResponse({
    type: ResponseDto<ICandidate>
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:candidate')
  async createCandidate(
    @Req() req: { user: IUser },
    @Body() candidateRequest: CreateCandidateRequestDto
  ): Promise<ResponseDto<ICandidate>> {
    const createCandidateResponse: IServiceResponse<ICandidate> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'candidate_create' },
        {
          ...candidateRequest,
          created_by: req.user.email
        }
      )
    );

    if (createCandidateResponse.status != HttpStatus.CREATED) {
      throw new HttpException({
        message: createCandidateResponse.message,
        data: null,
        errors: createCandidateResponse.errors,
      },
        createCandidateResponse.status);
    }
    return {
      message: createCandidateResponse.message,
      data: createCandidateResponse.data,
      errors: null
    };
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:candidate')
  @ApiOkResponse({
    type: ResponseDto<ICandidate[]>,
    description: 'List of candidates of user'
  })
  public async getCandidates(
    @Req() req: { user: IUser }
  ): Promise<ResponseDto<ICandidate[]>> {
    const candidatesResponse: IServiceResponse<ICandidate[]> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'candidates_list' }, {}),
    );

    return {
      message: candidatesResponse.message,
      data: candidatesResponse.data,
      errors: null,
    };
  }

  @Get(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:candidate')
  @ApiOkResponse({
    type: ResponseDto<ICandidate>,
    description: 'Candidate'
  })
  public async getCandidate(
    @Req() req: { user: IUser },
    @Param('id') id: string,
  ): Promise<ResponseDto<ICandidate>> {
    const candidateResponse: IServiceResponse<ICandidate> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'candidate_search_by_id' }, id),
    );

    return {
      message: candidateResponse.message,
      data: candidateResponse.data,
      errors: null,
    };
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:candidate')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete candidate'
  })
  public async deleteCandidate(
    @Param('id') id: string,
  ): Promise<ResponseDto<null>> {
    const deleteCandidateResponse: IServiceResponse<null> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'candidate_delete_by_id' }, {
        id: id
      }),
    );

    if (deleteCandidateResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: deleteCandidateResponse.message,
          errors: deleteCandidateResponse.errors,
          data: null,
        },
        deleteCandidateResponse.status,
      );
    }

    return {
      message: deleteCandidateResponse.message,
      data: null,
      errors: null,
    };
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:candidate')
  @ApiOkResponse({
    type: ResponseDto<ICandidate>,
    description: 'Update candidate'
  })
  public async updateCandidate(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() candidateRequest: UpdateCandidateRequestDto,
  ): Promise<ResponseDto<ICandidate>> {
    const updateCandidateResponse: IServiceResponse<ICandidate> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'candidate_update_by_id' }, {
        id: id,
        user: req.user.email,
        candidate: candidateRequest,
      }),
    );

    if (updateCandidateResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: updateCandidateResponse.message,
          errors: updateCandidateResponse.errors,
          data: null,
        },
        updateCandidateResponse.status,
      );
    }

    return {
      message: updateCandidateResponse.message,
      data: updateCandidateResponse.data,
      errors: null,
    };
  }

  @Post('import')
  @ApiCreatedResponse({
    type: ResponseDto<null>
  })
  async importCandidate(
    @Body() candidateRequest: ImportCandidateRequestDto
  ): Promise<ResponseDto<null>> {
    const createCandidateResponse: IServiceResponse<ICandidate> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'candidate_import' }, candidateRequest)
    );

    if (createCandidateResponse.status != HttpStatus.CREATED) {
      throw new HttpException({
        message: createCandidateResponse.message,
        errors: createCandidateResponse.errors,
      },
        createCandidateResponse.status);
    }
    return {
      message: createCandidateResponse.message,
      data: null,
      errors: null
    };
  }
}
