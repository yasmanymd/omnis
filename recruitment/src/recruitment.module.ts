import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MongoConfigService } from './services/config/mongo-config.service';
import { Token, TokenSchema } from './token/schemas/token.schema';
import { TokenService } from './token/token.service';
import { CandidatesController } from './candidates/candidates.controller';
import { CandidatesService } from './candidates/candidates.service';
import { Candidate, CandidateSchema } from './candidates/schemas/candidate.schema';
import { TokenController } from './token/token.controller';

@Module({
  imports: [
    MongooseModule.forRootAsync({ useClass: MongoConfigService }),
    MongooseModule.forFeature([{ name: Candidate.name, schema: CandidateSchema }]),
    MongooseModule.forFeature([{ name: Token.name, schema: TokenSchema }])
  ],
  controllers: [CandidatesController, TokenController],
  providers: [CandidatesService, TokenService],
})
export class RecruimentModule { }