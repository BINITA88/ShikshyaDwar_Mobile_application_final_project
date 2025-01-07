import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/data/data_source/local_datasource/local_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/repository/batch_repository.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';


class BatchLocalRepository implements IBatchRepository {
  final LocalDataSource _batchLocalDataSource;

  BatchLocalRepository({required LocalDataSource batchLocalDataSource})
      : _batchLocalDataSource = batchLocalDataSource;

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batch) {
    try {
      _batchLocalDataSource.createBatch(batch);
      return Future.value(Right(null));
    } catch (e) {
      return Future.value(Left(LocalDatabaseFailure(message: e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async {
    try {
      await _batchLocalDataSource
          .deleteBatch(id); // localdatasource ho ke datasource matra hoo
      return Right(null);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: 'Error deleting batch : $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    try {
      final batches = await _batchLocalDataSource.getAllBatches();
      return Right(batches);
    } catch (e) {
      return Left(
        LocalDatabaseFailure(message: 'Error getting all batches: $e'),
      );
    }
  }
}
