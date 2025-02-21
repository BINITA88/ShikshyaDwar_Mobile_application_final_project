import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';

class UnbookSeat {
  final IExamSeatRepository repository;

  UnbookSeat(this.repository);

  Future<Either<Failure, ExamSeatEntity>> call(String seatId) {
    return repository.unbookExamSeat(seatId);
  }
}
