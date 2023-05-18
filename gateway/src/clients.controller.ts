import { Body, Controller, Delete, Get, HttpException, HttpStatus, Inject, Param, Post, Put, Query, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiCreatedResponse, ApiBearerAuth } from '@nestjs/swagger';
import { ResponseDto } from './interfaces/common/response.dto';
import { CreateUpdateClientRequestDto } from './interfaces/clients/dto/create-update-client-request.dto';
import { Observable } from 'rxjs';
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
  @Permissions('create-client')
  async createClient(
    @Body() clientRequest: CreateUpdateClientRequestDto
  ): Promise<Observable<ResponseDto<IClient>>> {
    return this.recruitmentService.send({ cmd: 'client_create' }, clientRequest)
  }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read-client')
  @ApiOkResponse({
    type: ResponseDto<IClient[]>,
    description: 'List of clients of user'
  })
  public async getClients(): Promise<Observable<ResponseDto<IClient[]>>> {
    return this.recruitmentService.send({ cmd: 'clients_list' }, {});
  }

  @Get(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read-client')
  @ApiOkResponse({
    type: ResponseDto<IClient>,
    description: 'Client'
  })
  public async getClient(
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<IClient>>> {
    return this.recruitmentService.send({ cmd: 'client_search_by_id' }, id);
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('delete-client')
  @ApiOkResponse({
    type: ResponseDto<null>,
    description: 'Delete client'
  })
  public async deleteClient(
    @Param('id') id: string,
  ): Promise<Observable<ResponseDto<null>>> {
    return this.recruitmentService.send({ cmd: 'client_delete_by_id' }, {
      id: id
    });
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('update-client')
  @ApiOkResponse({
    type: ResponseDto<IClient>,
    description: 'Update client'
  })
  public async updateClient(
    @Req() req: { user: IUser },
    @Param('id') id: string,
    @Body() clientRequest: CreateUpdateClientRequestDto,
  ): Promise<Observable<ResponseDto<IClient>>> {
    return this.recruitmentService.send({ cmd: 'client_update_by_id' }, {
      id: id,
      user: req.user.email,
      client: clientRequest,
    });
  }
}
