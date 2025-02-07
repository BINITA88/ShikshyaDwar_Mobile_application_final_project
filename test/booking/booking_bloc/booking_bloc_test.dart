import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/presentation/view_model/booking/booking_state.dart';

import '../booking_usecase/booking_usecase.mock.dart';

void main() {
  late BookingBloc bookingBloc;
  late MockCreateBookingUsecase mockCreateBookingUsecase;

  final testBooking = BookingsEntity(
    bookId: '1',
    address: '123 Street',
    city: 'TestCity',
    country: 'TestCountry',
    status: 'Pending',
    user: Object(),
    shift: 'Morning',
    classMode: 'Online',
    interestedInCounseling: true,
  );

  setUp(() {
    mockCreateBookingUsecase = MockCreateBookingUsecase();
    bookingBloc = BookingBloc(createBookingUsecase: mockCreateBookingUsecase);

    // Register fallback for CreateBookingParams
    registerFallbackValue(CreateBookingParams(booking: testBooking));
  });

  tearDown(() {
    bookingBloc.close();
  });

  test('Initial state should be BookingInitial', () {
    expect(bookingBloc.state, BookingInitial());
  });

  blocTest<BookingBloc, BookingState>(
    'emits [BookingLoading, BookingCreated] when booking is successful',
    build: () {
      when(() => mockCreateBookingUsecase(any()))
          .thenAnswer((_) async => const Right(null));
      return bookingBloc;
    },
    act: (bloc) => bloc.add(CreateBookingEvent(booking: testBooking)),
    expect: () => [BookingLoading(), BookingCreated()],
    verify: (_) {
      verify(() => mockCreateBookingUsecase(
          CreateBookingParams(booking: testBooking))).called(1);
    },
  );

  blocTest<BookingBloc, BookingState>(
    'emits [BookingLoading, BookingError] when booking fails',
    build: () {
      when(() => mockCreateBookingUsecase(any()))
          .thenAnswer((_) async => Left(ApiFailure(message: 'Error')));
      return bookingBloc;
    },
    act: (bloc) => bloc.add(CreateBookingEvent(booking: testBooking)),
    expect: () => [BookingLoading(), BookingError('Error')],
    verify: (_) {
      verify(() => mockCreateBookingUsecase(
          CreateBookingParams(booking: testBooking))).called(1);
    },
  );
}
