import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IClient } from "./interfaces/client.interface";
import { ClientDocument } from "./schemas/client.schema";

@Injectable()
export class ClientsService {
  constructor(@InjectModel('Client') private readonly clientModel: Model<ClientDocument>) { }

  public async createClient(client: IClient): Promise<IClient> {
    return await this.clientModel.create(client);
  }

  public async getClients(): Promise<IClient[]> {
    return this.clientModel.find({});
  }

  public async getClientById(id: string): Promise<IClient> {
    return await this.clientModel.findById(id);
  }

  public async removeClientById(id: string) {
    return await this.clientModel.findOneAndDelete({ _id: id });
  }

  public async updateClientById(
    id: string,
    params: IClient,
  ): Promise<IClient> {
    return await this.clientModel.findByIdAndUpdate({ _id: id }, params, { new: true, upsert: true });
  }
}