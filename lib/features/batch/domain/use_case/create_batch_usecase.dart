import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/repository/batch_repository.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';


class CreateBatchParams extends Equatable {
  final String batchName;
  const CreateBatchParams({required this.batchName});

//  empty constructor
  const CreateBatchParams.empty() : 
  batchName = '_empty.string';

  @override
  // TODO: implement props
  List<Object?> get props => [batchName];
}

class CreateBatchUsecase implements UsecaseWithParams<void, CreateBatchParams> {
  final IBatchRepository batchRepository;

  CreateBatchUsecase({required this.batchRepository});

  @override
  Future<Either<Failure, void>> call(CreateBatchParams params) async {
    return await batchRepository

    // create garda batchentity bata lina parch so define garna parcha 
        .createBatch(BatchEntity(batchName: params.batchName));
  }
}
