import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/entity/exam_seat_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/book_seat.dart';
import 'package:shikshyadwar_mobile_application_project/features/exam%20seat/domain/use%20_case/get_all_seat.dart';

part 'exam_seat_event.dart';
part 'exam_seat_state.dart';

class ExamSeatBloc extends Bloc<ExamSeatEvent, ExamSeatState> {
  final GetAllSeat getAllSeat;
  final BookSeat bookSeat;

  ExamSeatBloc({required this.getAllSeat, required this.bookSeat}) : super(ExamSeatInitial()) {
    on<GetExamSeatsEvent>(_onGetExamSeats);
    on<BookExamSeatEvent>(_onBookExamSeat);
  }

  Future<void> _onGetExamSeats(GetExamSeatsEvent event, Emitter<ExamSeatState> emit) async {
    emit(ExamSeatLoading());
    final result = await getAllSeat();
    result.fold(
      (failure) => emit(ExamSeatError(failure.message)),
      (seats) => emit(ExamSeatLoaded(seats)),
    );
  }

  Future<void> _onBookExamSeat(BookExamSeatEvent event, Emitter<ExamSeatState> emit) async {
    if (state is ExamSeatLoaded) {
      final currentState = state as ExamSeatLoaded;

      emit(ExamSeatLoading());
      final result = await bookSeat(event.examSeatId);

      result.fold(
        (failure) => emit(ExamSeatError(failure.message)),
        (updatedSeat) {
          final updatedSeats = currentState.seats.map((seat) {
            return seat.examSeatId == updatedSeat.examSeatId ? updatedSeat : seat;
          }).toList();
          emit(ExamSeatLoaded(updatedSeats));
        },
      );
    }
  }
}
