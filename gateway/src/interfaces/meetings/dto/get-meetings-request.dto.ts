import { ApiProperty } from '@nestjs/swagger';

export class GetMeetingsRequestDto {
  @ApiProperty({ example: 'alan@test.com' })
  user: string;
}