import { Test, TestingModule } from '@nestjs/testing';
import { CandidatesController } from './candidates.controller';

describe('AppController', () => {
  let app: TestingModule;

  beforeAll(async () => {
    app = await Test.createTestingModule({
      controllers: [CandidatesController],
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
