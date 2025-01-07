import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/repository/batch_repository.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';


class GetAllBatchUsecase implements UsecaseWithoutParams<List<BatchEntity>>{
    final IBatchRepository batchRepository;

  GetAllBatchUsecase(this.batchRepository);

  @override
  Future<Either<Failure, List<BatchEntity>>> call(){
    return batchRepository.getAllBatches();
  }
}