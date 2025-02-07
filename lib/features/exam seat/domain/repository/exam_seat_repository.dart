import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

abstract interface class IExamSeatRepository {
  Future<Either<Failure, List<ExamSeatEntity>>> getAllExamSeat();
  Future<Either<Failure, ExamSeatEntity>> bookExamSeat(String examSeatId);
}
