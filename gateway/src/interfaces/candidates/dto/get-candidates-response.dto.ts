import { ApiProperty } from '@nestjs/swagger';
import { ICandidate } from '../candidate.interface';

export class GetCandidatesResponseDto {
  @ApiProperty({ example: 'get_candidates_success' })
  message: string;
  @ApiProperty({
    example: {
      candidates: [
        {
          name: 'Alan Rickman',
          created_at: +new Date(),
          created_by: 'Rick Montaris'
        },
        {
          name: 'John Doe',
          created_at: +new Date(),
          created_by: 'Robert Doe'
        }
      ]
    },
    nullable: true,
  })
  data: {
    candidates: ICandidate[];
  };
  @ApiProperty({ example: null, nullable: true })
  errors: { [key: string]: any };
}