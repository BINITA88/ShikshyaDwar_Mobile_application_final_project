import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/repository/batch_repository.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';


class DeleteBatchParams {
  final String batchId;

  const DeleteBatchParams({required this.batchId});

  //Empty constructor
  // yo testing bela kaam lagxa
  const DeleteBatchParams.empty() : batchId = '_empty.string';
}

class DeleteBatchUsecase implements UsecaseWithParams<void, DeleteBatchParams> {
  final IBatchRepository batchRepository;

  DeleteBatchUsecase({required this.batchRepository});

  @override
  Future<Either<Failure, void>> call(DeleteBatchParams params) {
    return batchRepository.deleteBatch(params.batchId);
  }
}
