import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';


// I lekhni adhi interface parent bujhauna
// aba hive servide ma jani
abstract interface class IBatchRepository {
  Future<Either<Failure, void>> createBatch(BatchEntity batchEntity);
  Future<Either<Failure, List<BatchEntity>>> getAllBatches();
  Future<Either<Failure, void>> deleteBatch(String id);
}


// repository chai domain layer ko ma garna parcha 