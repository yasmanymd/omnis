import { Controller, HttpStatus } from "@nestjs/common";
import { IResponse } from "../common/response.interface";
import { ICandidate, ICandidateImport } from "./interfaces/candidate.interface";
import { CandidatesService } from "./candidates.service";
import { MessagePattern } from '@nestjs/microservices';
import { TokenService } from "../token/token.service";
import { capitalizeTheFirstLetterOfEachWord } from "../common/utils";

@Controller()
export class CandidatesController {
  constructor(private readonly candidateService: CandidatesService, private readonly tokenService: TokenService) { }

  @MessagePattern({ cmd: 'candidates_list' })
  public async candidatesList(): Promise<IResponse<ICandidate[]>> {
    let result: IResponse<ICandidate[]>;


    const candidates = await this.candidateService.getCandidates();
    result = {
      status: HttpStatus.OK,
      message: 'candidates_list_success',
      data: candidates
    };

    return result;
  }

  @MessagePattern({ cmd: 'candidate_search_by_id' })
  public async candidateSearchById(id: string): Promise<IResponse<ICandidate>> {
    let result: IResponse<ICandidate>;

    const candidate = await this.candidateService.getCandidateById(id);
    result = {
      status: HttpStatus.OK,
      message: 'candidate_search_by_id_success',
      data: candidate
    };

    return result;
  }

  @MessagePattern({ cmd: 'candidates_search_by_user' })
  public async candidatesSearchByUser(user: string): Promise<IResponse<ICandidate[]>> {
    let result: IResponse<ICandidate[]>;

    if (user) {
      const candidates = await this.candidateService.getCandidatesByUser(user);
      result = {
        status: HttpStatus.OK,
        message: 'candidates_search_by_user_success',
        data: candidates
      };
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidates_search_by_user_bad_request',
        data: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'candidate_create' })
  public async candidateCreate(candidate: ICandidate): Promise<IResponse<ICandidate>> {
    let result: IResponse<ICandidate>;

    if (candidate) {
      try {
        const createdCandidate = await this.candidateService.createCandidate(
          Object.assign(candidate, {
            created_at: +new Date()
          })
        );
        result = {
          status: HttpStatus.CREATED,
          message: 'candidate_create_success',
          data: createdCandidate,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'candidate_create_precondition_failed',
          data: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidate_create_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'candidate_import' })
  public async candidateImport(candidate: ICandidateImport): Promise<IResponse<ICandidate>> {
    let result: IResponse<ICandidate>;

    if (candidate && candidate.contacts && candidate.contacts.linkedin) {
      const token = await this.tokenService.getUserByToken(candidate.token);
      if (token) {
        try {
          delete candidate.token;
          const createdCandidate = await this.candidateService.createCandidate(
            Object.assign(candidate, {
              name: capitalizeTheFirstLetterOfEachWord(candidate.name),
              status: 'None',
              created_by: token.user,
              created_at: +new Date()
            })
          );
          result = {
            status: HttpStatus.CREATED,
            message: 'candidate_import_success',
            data: createdCandidate,
            errors: null
          };
        } catch (e) {
          result = {
            status: HttpStatus.PRECONDITION_FAILED,
            message: 'candidate_import_precondition_failed',
            data: null,
            errors: e.errors
          };
        }
      } else {
        result = {
          status: HttpStatus.UNAUTHORIZED,
          message: 'candidate_import_unauthorized',
          data: null,
          errors: null
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidate_import_bad_request',
        data: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'candidate_update_by_id' })
  public async candidateUpdateById(params: {
    candidate: ICandidate;
    id: string;
    user: string;
  }): Promise<IResponse<ICandidate>> {
    let result: IResponse<ICandidate>;
    if (params.id) {
      try {
        const candidate = await this.candidateService.getCandidateById(params.id);
        if (candidate) {
          const updatedCandidate = await this.candidateService.updateCandidateById(candidate._id, params.candidate);
          result = {
            status: HttpStatus.OK,
            message: 'candidate_update_by_id_success',
            data: updatedCandidate,
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'candidate_update_by_id_not_found',
            data: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'candidate_update_by_id_precondition_failed',
          data: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidate_update_by_id_bad_request',
        data: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern({ cmd: 'candidate_delete_by_id' })
  public async candidateDeleteById(params: {
    id: string;
  }): Promise<IResponse<null>> {
    let result: IResponse<null>;

    if (params && params.id) {
      try {
        const candidate = await this.candidateService.getCandidateById(params.id);

        if (candidate) {
          await this.candidateService.removeCandidateById(params.id);
          result = {
            status: HttpStatus.OK,
            message: 'candidate_delete_by_id_success',
            errors: null,
          };
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'candidate_delete_by_id_not_found',
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.FORBIDDEN,
          message: 'candidate_delete_by_id_forbidden',
          errors: null,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidate_delete_by_id_bad_request',
        errors: null,
      };
    }

    return result;
  }
}