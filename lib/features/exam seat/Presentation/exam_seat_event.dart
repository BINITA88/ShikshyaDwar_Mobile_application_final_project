part of 'exam_seat_bloc.dart';


abstract class ExamSeatEvent extends Equatable {
  const ExamSeatEvent();

  @override
  List<Object> get props => [];
}

class GetExamSeatsEvent extends ExamSeatEvent {}

class BookExamSeatEvent extends ExamSeatEvent {
  final String examSeatId;

  const BookExamSeatEvent(this.examSeatId);

  @override
  List<Object> get props => [examSeatId];
}
