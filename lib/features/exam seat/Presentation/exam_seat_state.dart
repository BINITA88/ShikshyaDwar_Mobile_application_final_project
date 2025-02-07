part of 'exam_seat_bloc.dart';


abstract class ExamSeatState extends Equatable {
  const ExamSeatState();

  @override
  List<Object> get props => [];
}

class ExamSeatInitial extends ExamSeatState {}

class ExamSeatLoading extends ExamSeatState {}

class ExamSeatLoaded extends ExamSeatState {
  final List<ExamSeatEntity> seats;

  const ExamSeatLoaded(this.seats);

  @override
  List<Object> get props => [seats];
}

class ExamSeatError extends ExamSeatState {
  final String message;

  const ExamSeatError(this.message);

  @override
  List<Object> get props => [message];
}
