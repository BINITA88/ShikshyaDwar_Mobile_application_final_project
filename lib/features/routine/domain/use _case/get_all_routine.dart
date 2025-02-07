import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/repository/routine_repository.dart';

class GetAllRoutines implements UsecaseWithoutParams<List<RoutineEntity>> {
  final IRoutineRepository routineRepository;

  GetAllRoutines(this.routineRepository);

  @override
  Future<Either<Failure, List<RoutineEntity>>> call() {
    return routineRepository.getAllRoutines();
  }
}