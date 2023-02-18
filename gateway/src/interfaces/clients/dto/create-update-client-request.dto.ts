import { ApiProperty } from '@nestjs/swagger';

export class CreateUpdateClientRequestDto {
  @ApiProperty({ example: 'CGI' })
  name: string;

  @ApiProperty({ example: 'Company with 1000 employees.' })
  description: string;

  @ApiProperty({
    example: {
      email: 'alan@gmail.com',
      phone: '514-123-4567'
    }
  })
  contacts: { [key: string]: any };
}