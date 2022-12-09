import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { CreateCandidateResponseDto } from './interfaces/candidates/dto/create-candidate-response.dto';
import { CreateCandidateRequestDto } from './interfaces/candidates/dto/create-candidate-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceCreateCandidateResponse } from './interfaces/candidates/service-create-candidate-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { GetCandidatesResponseDto } from './interfaces/candidates/dto/get-candidates-response.dto';
import { IServiceGetCandidatesResponse } from './interfaces/candidates/service-get-candidates-response.interface';
import { DeleteCandidateResponseDto } from './interfaces/candidates/dto/delete-candidate-response.dto';
import { IUser } from './interfaces/user/user.interface';
import { IServiceCandidateDeleteResponse } from './interfaces/candidates/service-candidate-delete-response.interface';
import { UpdateCandidateResponseDto } from './interfaces/candidates/dto/update-candidate-response.dto';
import { UpdateCandidateRequestDto } from './interfaces/candidates/dto/update-candidate-request.dto';
import { IServiceCandidateUpdateByIdResponse } from './interfaces/candidates/service-candidate-update-by-id-response.interface';
import { ImportCandidateRequestDto } from './interfaces/candidates/dto/import-candidate-request.dto';

@Controller('candidates')
export class CandidatesController {
  constructor(@Inject('CANDIDATE_SERVICE') private readonly candidateService: ClientProxy) { }

  @Post()
  @ApiCreatedResponse({
    type: CreateCandidateResponseDto
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:candidate')
  async createCandidate(
    @Req() req: { user: IUser },
    @Body() candidateRequest: CreateCandidateRequestDto
  ): Promise<CreateCandidateResponseDto> {
    const createCandidateResponse: IServiceCreateCandidateResponse = await firstValueFrom(
      this.candidateService.send(
        'candidate_create',
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
      data: {
        candidate: createCandidateResponse.candidate
      },
      errors: null
    };
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:candidate')
  @ApiOkResponse({
    type: GetCandidatesResponseDto,
    description: 'List of candidates of user'
  })
  public async getCandidates(
    @Req() req: { user: IUser }
  ): Promise<GetCandidatesResponseDto> {
    const candidatesResponse: IServiceGetCandidatesResponse = await firstValueFrom(
      this.candidateService.send('candidates_search_by_user', req.user.email),
    );

    return {
      message: candidatesResponse.message,
      data: {
        candidates: candidatesResponse.candidates
      },
      errors: null,
    };
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:candidate')
  @ApiOkResponse({
    type: DeleteCandidateResponseDto,
    description: 'Delete candidate'
  })
  public async deleteCandidate(
    @Req() req: { user: IUser },
    @Param('id') id: string,
  ): Promise<DeleteCandidateResponseDto> {
    const deleteCandidateResponse: IServiceCandidateDeleteResponse = await firstValueFrom(
      this.candidateService.send('candidate_delete_by_id', {
        id: id,
        user: req.user.email
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
    type: UpdateCandidateResponseDto,
    description: 'Update candidate'
  })
  public async updateCandidate(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() candidateRequest: UpdateCandidateRequestDto,
  ): Promise<UpdateCandidateResponseDto> {
    const updateCandidateResponse: IServiceCandidateUpdateByIdResponse = await firstValueFrom(
      this.candidateService.send('candidate_update_by_id', {
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
      data: {
        candidate: updateCandidateResponse.candidate,
      },
      errors: null,
    };
  }

  @Post('import')
  @ApiCreatedResponse({
    type: CreateCandidateResponseDto
  })
  async importCandidate(
    @Body() candidateRequest: ImportCandidateRequestDto
  ): Promise<CreateCandidateResponseDto> {
    const createCandidateResponse: IServiceCreateCandidateResponse = await firstValueFrom(
      this.candidateService.send('candidate_import', candidateRequest)
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
      data: {
        candidate: createCandidateResponse.candidate
      },
      errors: null
    };
  }
}
