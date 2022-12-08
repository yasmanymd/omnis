import { ApiProperty } from '@nestjs/swagger';

export class CreateCandidateRequestDto {
  @ApiProperty({ example: 'Alan Rickman' })
  name: string;

  @ApiProperty({ example: 'Senior Software Developer' })
  title: string;

  @ApiProperty({
    example: {
      email: 'alan@gmail.com',
      phone: '514-123-4567',
      linkedin: 'https://linkedin.com/in/alanrickman'
    }
  })
  contacts: { [key: string]: any };

  @ApiProperty({ example: 'Opened' })
  status: string;

  @ApiProperty({ example: '100k-120k' })
  salary: string;
}