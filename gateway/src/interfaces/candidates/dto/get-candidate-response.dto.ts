import { ApiProperty } from '@nestjs/swagger';
import { ICandidate } from '../candidate.interface';

export class GetCandidateResponseDto {
  @ApiProperty({ example: 'get_candidate_success' })
  message: string;
  @ApiProperty({
    example: {
      candidate:
      {
        name: 'Alan Rickman',
        contacts: {
          email: 'alan@gmail.com',
          phone: '514-123-4567',
          linkedin: 'https://linkedin.com/in/alanrickman'
        },
        created_at: +new Date(),
        created_by: 'Rick Montaris'
      }
    },
    nullable: true,
  })
  data: {
    candidate: ICandidate;
  };
  @ApiProperty({ example: null, nullable: true })
  errors: { [key: string]: any };
}