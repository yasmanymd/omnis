import { Controller, HttpStatus } from "@nestjs/common";
import { IResponse } from "../common/response.interface";
import { IClient } from "./interfaces/client.interface";
import { ClientsService } from "./clients.service";
import { MessagePattern } from '@nestjs/microservices';

@Controller()
export class ClientsController {
  constructor(private readonly clientService: ClientsService) { }

  @MessagePattern({ cmd: 'clients_list' })
  public async clientsList(): Promise<IResponse<IClient[]>> {
    let result: IResponse<IClient[]>;


    const clients = await this.clientService.getClients();
    result = {
      status: HttpStatus.OK,
      message: 'clients_list_success',
      data: clients
    };

    return result;
  }

  @MessagePattern({ cmd: 'client_search_by_id' })
  public async clientSearchById(id: string): Promise<IResponse<IClient>> {
    let result: IResponse<IClient>;

    const client = await this.clientService.getClientById(id);
    result = {
      status: HttpStatus.OK,
      message: 'client_search_by_id_success',
      data: client
    };

    return result;
  }

  @MessagePattern({ cmd: 'client_create' })
  public async clientCreate(client: IClient): Promise<IResponse<IClient>> {
    let result: IResponse<IClient>;

    if (client) {
      try {
        const createdClient = await this.clientService.createClient(client);
        result = {
          status: HttpStatus.CREATED,
          message: 'client_create_success',
          data: createdClient,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'client_create_precondition_failed',
          data: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'client_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'client_update_by_id' })
  public async clientUpdateById(params: {
    client: IClient;
    id: string;
  }): Promise<IResponse<IClient>> {
    let result: IResponse<IClient>;
    if (params.id) {
      try {
        const client = await this.clientService.getClientById(params.id);
        if (client) {
          const updatedClient = await this.clientService.updateClientById(client._id, Object.assign(client, params.client));
          result = {
            status: HttpStatus.OK,
            message: 'client_update_by_id_success',
            data: updatedClient,
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'client_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'client_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'client_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'client_delete_by_id' })
  public async clientDeleteForUser(params: {
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.id) {
      try {
        const client = await this.clientService.getClientById(params.id);

        if (client) {
          await this.clientService.removeClientById(params.id);
          result = {
            status: HttpStatus.OK,
            message: 'client_delete_by_id_success',
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'client_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'client_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'client_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}