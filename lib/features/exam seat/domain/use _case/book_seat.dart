import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// ✅ Additional Helper to Determine Seat Color
import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/repository/exam_seat_repository.dart';

class BookSeat implements UsecaseWithParams<ExamSeatEntity, String> {
  final IExamSeatRepository repository;

  BookSeat(this.repository);

  @override
  Future<Either<Failure, ExamSeatEntity>> call(String examSeatId) async {
    return repository.bookExamSeat(examSeatId);
  }
}


class SeatColorHelper {
  static Color getSeatColor(bool isBooked) {
    return isBooked ? Colors.grey : Colors.lightBlue;
  }
}
