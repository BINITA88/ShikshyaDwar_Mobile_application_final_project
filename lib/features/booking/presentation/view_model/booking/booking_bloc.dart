import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/presentation/payment_bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final CreateBookingUsecase createBookingUsecase;
  final PaymentBloc paymentBloc;

  BookingBloc({
    required this.paymentBloc,
    required this.createBookingUsecase,
  }) : super(BookingInitial()) {
    on<CreateBookingEvent>(_onCreateBooking);
    on<NavigatePaymentScreenEvent>(_onNavigatePaymentScreen);
  }

  // Handle creating a booking
  Future<void> _onCreateBooking(
    CreateBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());

    final Either<Failure, void> result =
        await createBookingUsecase(CreateBookingParams(booking: event.booking));

    result.fold(
      (failure) => emit(BookingError(failure.message)),
      (_) => emit(BookingCreated()),
    );
  }

  // Handle navigation to payment screen
  void _onNavigatePaymentScreen(
    NavigatePaymentScreenEvent event,
    Emitter<BookingState> emit,
  ) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: paymentBloc),
          ],
          child: event.destination,
        ),
      ),
    );
  }
}
