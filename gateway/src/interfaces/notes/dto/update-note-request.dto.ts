import { ApiProperty } from '@nestjs/swagger';

export class UpdateNoteRequestDto {
  @ApiProperty({ example: 'Candidate with 8 years of experience, etc' })
  note: string;

  @ApiProperty({ example: '63e7f83ff12db50885e11c2d' })
  candidate_id: string;
}