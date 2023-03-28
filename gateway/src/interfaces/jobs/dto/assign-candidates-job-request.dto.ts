import { ApiProperty } from '@nestjs/swagger';

export class AssignCandidatesToJobRequestDto {
  @ApiProperty({ example: ['63ed16efc451054027a05a21', '65ed16efc451054027a05a22'] })
  candidates: string[];

  @ApiProperty({ example: '61ad16efc451054027a05a21' })
  job: string;
}