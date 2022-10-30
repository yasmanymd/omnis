import { ApiProperty } from '@nestjs/swagger';
import { IMeeting } from '../meeting.interface';

export class GetMeetingsResponseDto {
  @ApiProperty({ example: 'get_meetings_success' })
  message: string;
  @ApiProperty({
    example: {
      meetings: [
        {
          name: 'Meeting with Alan',
          code: '123-456-789',
          description: 'Interview for Senior Software Developer position.',
          participants: ['rick@test.com', 'alan@test.com'],
          start_time: +new Date(),
          status: 'created',
          created_at: +new Date()
        },
        {
          name: 'Meeting with Robert',
          code: '456-789-123',
          description: 'Interview for Junio Software Developer position.',
          participants: ['robert@test.com', 'alan@test.com'],
          start_time: +new Date(),
          status: 'created',
          created_at: +new Date()
        }
      ]
    },
    nullable: true,
  })
  data: {
    meetings: IMeeting[];
  };
  @ApiProperty({ example: null, nullable: true })
  errors: { [key: string]: any };
}