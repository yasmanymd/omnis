import { ApiProperty } from '@nestjs/swagger';

export class CreateUpdateJobRequestDto {
  @ApiProperty({ example: 'Net Developer' })
  title: string;

  @ApiProperty({ example: 'Need .Net Developer for 1 year.' })
  description: string;

  @ApiProperty({
    example: {
      email: 'alan@gmail.com',
      phone: '514-123-4567'
    }
  })
  contacts: { [key: string]: any };

  @ApiProperty({
    example: ['.Net', 'Java']
  })
  tags: string[];

  @ApiProperty({ example: '63ed16efc451054027a05a21' })
  client_id: string;

  @ApiProperty({ description: 'Used only on creation', example: '63ed16efc451054027a11111' })
  workflow_template_id: string;
}