import { ApiProperty } from '@nestjs/swagger';

export class ResponseDto<Type> {
  @ApiProperty({ example: 'candidate_create_success' })
  message: string;
  @ApiProperty({
    example: {
      data: {
        name: 'Alan Rickman',
        contacts: {
          email: 'alan@gmail.com'
        },
        created_at: +new Date(),
        created_by: 'Rick Montaris'
      },
    },
    nullable: true,
  })
  data: Type;
  @ApiProperty({ example: null, nullable: true })
  errors: { [key: string]: any };
}