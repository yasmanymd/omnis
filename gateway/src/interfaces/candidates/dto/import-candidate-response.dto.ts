import { ApiProperty } from '@nestjs/swagger';

export class ImportCandidateResponseDto {
  @ApiProperty({ example: 'candidate_create_success' })
  message: string;

  @ApiProperty({ example: null, nullable: true })
  errors: { [key: string]: any };
}