
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';

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
