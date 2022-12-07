import { ApiProperty } from '@nestjs/swagger';

export class CreateCandidateRequestDto {
  @ApiProperty({ example: 'Yasmany Molina Diaz' })
  name: string;
}