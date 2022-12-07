import { Controller, HttpStatus } from "@nestjs/common";
import { ICandidateCreateResponse } from "./interfaces/candidate-create-response.interface";
import { ICandidate } from "./interfaces/candidate.interface";
import { CandidatesService } from "./candidates.service";
import { MessagePattern } from '@nestjs/microservices';
import { ICandidatesSearchByUserResponse } from "./interfaces/candidates-search-by-user-response.interface";
import { ICandidateUpdateByIdResponse } from "./interfaces/candidate-update-by-id-response.interface";
import { ICandidateUpdateParams } from "./interfaces/candidate-update-params.interface";
import { ICandidateDeleteResponse } from "./interfaces/candidate-delete-response.interface";

@Controller()
export class CandidatesController {
  constructor(private readonly candidateService: CandidatesService) { }

  @MessagePattern('candidates_search_by_user')
  public async candidatesSearchByUser(user: string): Promise<ICandidatesSearchByUserResponse> {
    let result: ICandidatesSearchByUserResponse;

    if (user) {
      const candidates = await this.candidateService.getCandidatesByUser(user);
      result = {
        status: HttpStatus.OK,
        message: 'candidates_search_by_user_success',
        candidates: candidates
      };
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidates_search_by_user_bad_request',
        candidates: null
      };
    }

    return result;
  }

  @MessagePattern('candidate_create')
  public async candidateCreate(candidate: ICandidate): Promise<ICandidateCreateResponse> {
    let result: ICandidateCreateResponse;

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
          candidate: createdCandidate,
          errors: null
        };
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'candidate_create_precondition_failed',
          candidate: null,
          errors: e.errors
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidate_create_bad_request',
        candidate: null,
        errors: null
      };
    }

    return result;
  }

  @MessagePattern('candidate_update_by_id')
  public async candidateUpdateById(params: {
    candidate: ICandidate;
    id: string;
    user: string;
  }): Promise<ICandidateUpdateByIdResponse> {
    let result: ICandidateUpdateByIdResponse;
    if (params.id) {
      try {
        const candidate = await this.candidateService.getCandidateById(params.id);
        if (candidate) {
          if (candidate.created_by === params.user) {
            const updatedCandidate = await this.candidateService.updateCandidateById(candidate._id, Object.assign(candidate, params.candidate));
            result = {
              status: HttpStatus.OK,
              message: 'candidate_update_by_id_success',
              candidate: updatedCandidate,
              errors: null,
            };
          } else {
            result = {
              status: HttpStatus.FORBIDDEN,
              message: 'candidate_update_by_id_forbidden',
              candidate: null,
              errors: null,
            };
          }
        } else {
          result = {
            status: HttpStatus.NOT_FOUND,
            message: 'candidate_update_by_id_not_found',
            candidate: null,
            errors: null,
          };
        }
      } catch (e) {
        result = {
          status: HttpStatus.PRECONDITION_FAILED,
          message: 'candidate_update_by_id_precondition_failed',
          candidate: null,
          errors: e.errors,
        };
      }
    } else {
      result = {
        status: HttpStatus.BAD_REQUEST,
        message: 'candidate_update_by_id_bad_request',
        candidate: null,
        errors: null,
      };
    }

    return result;
  }

  @MessagePattern('candidate_delete_by_id')
  public async candidateDeleteForUser(params: {
    user: string;
    id: string;
  }): Promise<ICandidateDeleteResponse> {
    let result: ICandidateDeleteResponse;

    if (params && params.user && params.id) {
      try {
        const candidate = await this.candidateService.getCandidateById(params.id);

        if (candidate) {
          if (candidate.created_by === params.user) {
            await this.candidateService.removeCandidateById(params.id);
            result = {
              status: HttpStatus.OK,
              message: 'candidate_delete_by_id_success',
              errors: null,
            };
          } else {
            result = {
              status: HttpStatus.FORBIDDEN,
              message: 'candidate_delete_by_id_forbidden',
              errors: null,
            };
          }
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