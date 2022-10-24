import { Test, TestingModule } from '@nestjs/testing';
import { MeetingsController } from './meetings.controller';

describe('AppController', () => {
  let app: TestingModule;

  beforeAll(async () => {
    app = await Test.createTestingModule({
      controllers: [MeetingsController],
      providers: [],
    }).compile();
  });

  /*describe('createTask', () => {
    it('should return "Hello World!"', () => {
      const appController = app.get(AppController);
      expect(appController.createMeeting()).toBe('Hello World!');
    });
  });*/
});
