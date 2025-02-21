import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import '../entity/exam_seat_entity.dart';

abstract class IExamSeatRepository {
  /// ✅ Fetch all exam seats
  Future<Either<Failure, List<ExamSeatEntity>>> getAllExamSeat();

  /// ✅ Book an exam seat
  Future<Either<Failure, ExamSeatEntity>> bookExamSeat(String examSeatId);

  /// ✅ Unbook an exam seat
  Future<Either<Failure, ExamSeatEntity>> unbookExamSeat(String examSeatId);

  /// ✅ Check Seat Status (Booked or Available)
  Future<Either<Failure, bool>> checkSeatStatus(String examSeatId);
}
