import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';

class GetAllSeat implements UsecaseWithoutParams<List<ExamSeatEntity>> {
  final IExamSeatRepository repository;

  GetAllSeat(this.repository);

  @override
  Future<Either<Failure, List<ExamSeatEntity>>> call() {
    return repository.getAllExamSeat();
  }
}
