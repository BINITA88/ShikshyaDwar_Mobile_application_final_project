import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';

abstract class RoutineRepository {
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines();
}
