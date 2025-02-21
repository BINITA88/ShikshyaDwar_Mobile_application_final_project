
import 'package:equatable/equatable.dart';

abstract class ExamSeatEvent extends Equatable {
  const ExamSeatEvent();

  @override
  List<Object> get props => [];
}

/// ✅ Fetch all exam seats
class GetExamSeatsEvent extends ExamSeatEvent {}

/// ✅ Book a seat
class BookExamSeatEvent extends ExamSeatEvent {
  final String examSeatId;

  const BookExamSeatEvent(this.examSeatId);

  @override
  List<Object> get props => [examSeatId];
}

/// ✅ Unbook a seat (NEW EVENT)
class UnbookExamSeatEvent extends ExamSeatEvent {
  final String examSeatId;

  const UnbookExamSeatEvent(this.examSeatId);

  @override
  List<Object> get props => [examSeatId];
}
