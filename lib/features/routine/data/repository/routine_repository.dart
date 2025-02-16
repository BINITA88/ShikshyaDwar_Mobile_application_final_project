import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/data/data_source/remote_datasource/routine_remote_datasource_impl.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/repository/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineRemoteDataSource routineRemoteDataSource; // ✅ Use the interface

  RoutineRepositoryImpl({required this.routineRemoteDataSource});

  @override
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines() async {
    try {
      final routines = await routineRemoteDataSource.fetchRoutines();
      return Right(routines);
    } catch (e) {
      return Left(ApiFailure(message: 'Failed to load routines'));
    }
  }
}
