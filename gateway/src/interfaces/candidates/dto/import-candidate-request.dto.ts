import { ApiProperty } from '@nestjs/swagger';

export class ImportCandidateRequestDto {
  @ApiProperty({ example: 'sd3s5-67r5558gvvv90-ertefbnc3ws31', required: true })
  token: string;

  @ApiProperty({ example: 'Alan Rickman', required: true })
  name: string;

  @ApiProperty({ example: 'Senior Software Developer', required: false })
  title: string;

  @ApiProperty({
    example: {
      email: 'alan@gmail.com',
      phone: '514-123-4567',
      linkedin: 'https://linkedin.com/in/alanrickman'
    },
    required: false
  })
  contacts: { [key: string]: any };

  @ApiProperty({ example: '100k-120k', required: false })
  salary: string;
}