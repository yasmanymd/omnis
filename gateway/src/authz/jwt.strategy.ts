import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor() {
    const publicKey = `-----BEGIN PUBLIC KEY-----
${process.env.KEYCLOACK_PUBLIC_KEY}
-----END PUBLIC KEY-----`;
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: publicKey
    });
  }

  validate(payload: unknown): unknown {
    return payload;
  }
}