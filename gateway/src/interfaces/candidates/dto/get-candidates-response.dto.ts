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
          contacts: {
            email: 'alan@gmail.com',
            phone: '514-123-4567',
            linkedin: 'https://linkedin.com/in/alanrickman'
          },
          created_at: +new Date(),
          created_by: 'Rick Montaris'
        },
        {
          name: 'John Doe',
          contacts: {
            email: 'john@gmail.com',
            phone: '514-123-4567',
            linkedin: 'https://linkedin.com/in/johndoe'
          },
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