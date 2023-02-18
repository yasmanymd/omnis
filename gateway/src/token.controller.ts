import { Controller, Get, Inject, Put, Req, UseGuards } from '@nestjs/common';
import { ClientProxy } from '@nestjs/microservices';
import { ApiOkResponse, ApiBearerAuth } from '@nestjs/swagger';
import { firstValueFrom } from 'rxjs';
import { AuthGuard } from '@nestjs/passport';
import { Permissions } from './authz/permissions.decorator';
import { PermissionsGuard } from './authz/permissions.guard';
import { IUser } from './interfaces/user/user.interface';
import { TokenDto } from './interfaces/token/dto/token.dto';

@Controller('token')
export class TokenController {
  constructor(@Inject('RECRUITMENT_SERVICE') private readonly recruitmentService: ClientProxy) { }

  @Get()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('read:token')
  @ApiOkResponse({
    type: TokenDto,
    description: 'Read token'
  })
  public async getToken(
    @Req() req: { user: IUser }
  ): Promise<TokenDto> {
    const tokenResponse: TokenDto = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'token_search_by_user' }, req.user.email)
    );

    return tokenResponse;
  }

  @Put()
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('edit:token')
  @ApiOkResponse({
    type: TokenDto,
    description: 'Regenerate token'
  })
  public async regenerateToken(
    @Req() req: { user: IUser }
  ): Promise<TokenDto> {
    const tokenResponse: TokenDto = await firstValueFrom(
      this.recruitmentService.send({ cmd: 'token_regenerate' }, req.user.email)
    );

    return tokenResponse;
  }
}
