import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';

class BookSeat implements UsecaseWithParams<ExamSeatEntity, String> {
  final IExamSeatRepository repository;

  BookSeat(this.repository);

  @override
  Future<Either<Failure, ExamSeatEntity>> call(String examSeatId) {
    return repository.bookExamSeat(examSeatId);
  }
}
