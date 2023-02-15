import { Test, TestingModule } from '@nestjs/testing';
import { NotesController } from './notes.controller';

describe('AppController', () => {
  let app: TestingModule;

  beforeAll(async () => {
    app = await Test.createTestingModule({
      controllers: [NotesController],
      providers: [],
    }).compile();
  });

  /*describe('createNote', () => {
    it('should return "Hello World!"', () => {
      const appController = app.get(NotesController);
      expect(appController.createNote(
        { user: { sub: '', email: 'test@gmail.com' } },
        {
          "note": "Test create note",
          "candidate_id": "63e7f83ff12db50885e11c2d"
        })).toBe('Hello World!');
    });
  });*/
});
