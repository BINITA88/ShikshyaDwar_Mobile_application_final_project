import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/entity/routine_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/routine/domain/repository/routine_repository.dart';

class GetAllRoutinesUseCase implements UsecaseWithoutParams<List<RoutineEntity>> {
  final RoutineRepository routineRepository; // ✅ Use Interface

  GetAllRoutinesUseCase({required this.routineRepository});

  @override
  Future<Either<Failure, List<RoutineEntity>>> call() {
    return routineRepository.getAllRoutines();
  }
}
