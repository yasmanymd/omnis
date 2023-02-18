import { Test, TestingModule } from '@nestjs/testing';
import { JobsController } from './jobs.controller';

describe('AppController', () => {
  let app: TestingModule;

  beforeAll(async () => {
    app = await Test.createTestingModule({
      controllers: [JobsController],
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
