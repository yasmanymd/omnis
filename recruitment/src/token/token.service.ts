import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { IToken } from "./interfaces/token.interface";
import { TokenDocument } from "./schemas/token.schema";

@Injectable()
export class TokenService {
  constructor(@InjectModel('Token') private readonly tokenModel: Model<TokenDocument>) { }

  public async createToken(token: IToken): Promise<IToken> {
    const tokenModel = new this.tokenModel(token);
    return await tokenModel.save();
  }

  public async getUserByToken(token: string): Promise<IToken> {
    return this.tokenModel.findOne({ token: token }).exec();
  }

  public async getTokenByUser(user: string): Promise<IToken> {
    return this.tokenModel.findOne({ user: user }).exec();
  }

  public async updateTokenByUser(
    params: IToken,
  ): Promise<IToken> {
    return await this.tokenModel.findOneAndUpdate({ user: params.user }, params);
  }
}