import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { CreateUpdateClientRequestDto } from './interfaces/clients/dto/create-update-client-request.dto';
import { firstValueFrom } from 'rxjs';
import { IServiceResponse } from './interfaces/common/service-response.interface';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { IClient } from './interfaces/clients/client.interface';

@Controller('clients')
export class ClientsController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

  @Post()
  @ApiCreatedResponse({
    type: ResponseDto<IClient>
  })
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('create:client')
  async createClient(
    @Body() clientRequest: CreateUpdateClientRequestDto
  ): Promise<ResponseDto<IClient>> {
    const createClientResponse: IServiceResponse<IClient> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'client_create' }, clientRequest)
    );

    if (createClientResponse.status != HttpStatus.CREATED) {
      throw new HttpException({
        message: createClientResponse.message,
        data: null,
        errors: createClientResponse.errors,
      },
        createClientResponse.status);
    }
    return {
      message: createClientResponse.message,
      data: createClientResponse.data,
      errors: null
    };
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:client')
  @ApiOkResponse({
    type: ResponseDto<IClient[]>,
    description: 'List of clients of user'
  })
  public async getClients(): Promise<ResponseDto<IClient[]>> {
    const clientsResponse: IServiceResponse<IClient[]> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'clients_list' }, {}),
    );

    return {
      message: clientsResponse.message,
      data: clientsResponse.data,
      errors: null,
    };
  }

  @Get(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:client')
  @ApiOkResponse({
    type: ResponseDto<IClient>,
    description: 'Client'
  })
  public async getClient(
    @Param('id') id: string,
  ): Promise<ResponseDto<IClient>> {
    const clientResponse: IServiceResponse<IClient> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'client_search_by_id' }, id),
    );

    return {
      message: clientResponse.message,
      data: clientResponse.data,
      errors: null,
    };
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete:client')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete client'
  })
  public async deleteClient(
    @Param('id') id: string,
  ): Promise<ResponseDto<null>> {
    const deleteClientResponse: IServiceResponse<null> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'client_delete_by_id' }, {
        id: id
      }),
    );

    if (deleteClientResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: deleteClientResponse.message,
          errors: deleteClientResponse.errors,
          data: null,
        },
        deleteClientResponse.status,
      );
    }

    return {
      message: deleteClientResponse.message,
      data: null,
      errors: null,
    };
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:client')
  @ApiOkResponse({
    type: ResponseDto<IClient>,
    description: 'Update client'
  })
  public async updateClient(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() clientRequest: CreateUpdateClientRequestDto,
  ): Promise<ResponseDto<IClient>> {
    const updateClientResponse: IServiceResponse<IClient> = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'client_update_by_id' }, {
        id: id,
        user: req.user.email,
        client: clientRequest,
      }),
    );

    if (updateClientResponse.status !== HttpStatus.OK) {
      throw new HttpException(
        {
          message: updateClientResponse.message,
          errors: updateClientResponse.errors,
          data: null,
        },
        updateClientResponse.status,
      );
    }

    return {
      message: updateClientResponse.message,
      data: updateClientResponse.data,
      errors: null,
    };
  }
}
