import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUsecase createBookingUsecase;

  BookingBloc({required this.createBookingUsecase}) : super(BookingInitial()) {
    on<CreateBookingEvent>(_onCreateBooking);
  }

  Future<void> _onCreateBooking(
      CreateBookingEvent event, Emitter<BookingState> emit) async {
    emit(BookingLoading());

    final Either<Failure, void> result =
        await createBookingUsecase(CreateBookingParams(booking: event.booking));

    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (_) => emit(BookingCreated()),
    );
  }
}
