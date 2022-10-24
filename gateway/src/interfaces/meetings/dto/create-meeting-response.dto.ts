import { ApiProperty } from '@nestjs/swagger';
import { IMeeting } from '../meeting.interface';

export class CreateMeetingResponseDto {
  @ApiProperty({ example: 'meeting_create_success' })
  message: string;
  @ApiProperty({
    example: {
      meeting: {
        name: 'Meeting with Alan',
        code: '123-456-789',
        description: 'Interview for Senior Software Developer position.',
        participants: ['rick@test.com', 'alan@test.com'],
        start_time: +new Date(),
        status: 'created',
        created_at: +new Date()
      },
    },
    nullable: true,
  })
  data: {
    meeting: IMeeting;
  };
  @ApiProperty({ example: null, nullable: true })
  errors: { [key: string]: any };
}