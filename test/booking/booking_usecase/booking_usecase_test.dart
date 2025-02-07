import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/repository/booking_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/use_case/create_booking_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';

class MockBookingRepository extends Mock implements IBookingRepository {}

void main() {
  late MockBookingRepository mockBookingRepository;
  late CreateBookingUsecase createBookingUsecase;

  final BookingsEntity booking = BookingsEntity(
    bookId: "123",
    address: "123 Street",
    city: "City",
    country: "Country",
    status: "Pending",
    user: Object(), // Replace with actual user model
    shift: "Morning",
    classMode: "Online",
    interestedInCounseling: true,
  );

  setUp(() {
    mockBookingRepository = MockBookingRepository();
    createBookingUsecase = CreateBookingUsecase(bookingRepository: mockBookingRepository);
  });

  test('Should return void when repository call is successful', () async {
    // Arrange
    when(() => mockBookingRepository.createBooking(booking))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await createBookingUsecase(CreateBookingParams(booking: booking));

    // Assert
    expect(result, const Right(null));
    verify(() => mockBookingRepository.createBooking(booking)).called(1);
  });

  test('Should return a Failure when repository call fails', () async {
    // Arrange
    final failure = ApiFailure(message: 'Server error');
    when(() => mockBookingRepository.createBooking(booking))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await createBookingUsecase(CreateBookingParams(booking: booking));

    // Assert
    expect(result, Left(failure));
    verify(() => mockBookingRepository.createBooking(booking)).called(1);
  });
}
