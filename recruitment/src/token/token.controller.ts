import { Controller, HttpStatus } from "@nestjs/common";
import { MessagePattern } from '@nestjs/microservices';
import { TokenService } from "../token/token.service";
import { IToken } from "./interfaces/token.interface";
import { v4 as uuidv4 } from 'uuid';

@Controller()
export class TokenController {
  constructor(private readonly tokenService: TokenService) { }

  @MessagePattern('token_search_by_user')
  public async tokenSearchByUser(user: string): Promise<IToken> {
    if (user) {
      let token = await this.tokenService.getTokenByUser(user);
      if (!token) {
        token = await this.tokenService.createToken({ user: user, token: uuidv4() })
      }
      return token;
    }

    return null;
  }

  @MessagePattern('token_regenerate')
  public async tokenRegenerate(user: string): Promise<IToken> {
    if (user) {
      let token = await this.tokenService.getTokenByUser(user);
      if (!token) {
        token = await this.tokenService.createToken({ user: user, token: uuidv4() });
      } else {
        await this.tokenService.updateTokenByUser({ user: user, token: uuidv4() });
        token = await this.tokenService.getTokenByUser(user);
      }
      return token;
    }

    return null;
  }
}