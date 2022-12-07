import { ApiProperty } from '@nestjs/swagger';

export class UpdateCandidateRequestDto {
  @ApiProperty({ example: 'Alan Rickman' })
  name: string;
}