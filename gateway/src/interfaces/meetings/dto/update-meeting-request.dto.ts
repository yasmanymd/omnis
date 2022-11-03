import { ApiProperty } from '@nestjs/swagger';

export class UpdateMeetingRequestDto {
  @ApiProperty({ example: 'Meeting with Alan' })
  name: string;
  @ApiProperty({ example: 'Interview for Senior Software Developer position.' })
  description: string;
  @ApiProperty({ example: ['rick@test.com', 'alan@test.com'] })
  participants: string[];
  @ApiProperty({ example: 30 })
  duration: number;
  @ApiProperty({ example: 4 })
  max_person: number;
  @ApiProperty({ example: +new Date() })
  start_time: number;
}