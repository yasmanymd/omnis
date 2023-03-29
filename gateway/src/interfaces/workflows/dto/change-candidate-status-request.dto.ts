import { ApiProperty } from '@nestjs/swagger';

export class ChangeCandidateStatusRequestDto {
  @ApiProperty({ example: '63ed16efc451054027a05a21' })
  candidate: string;

  @ApiProperty({ example: 'Interview' })
  status: string;
}