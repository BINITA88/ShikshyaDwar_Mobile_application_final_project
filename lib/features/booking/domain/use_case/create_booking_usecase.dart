import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/repository/booking_repository.dart';

class CreateBookingParams extends Equatable {
  final BookingsEntity booking;

  const CreateBookingParams({required this.booking});

  @override
  List<Object?> get props => [booking];
}

class CreateBookingUsecase
    implements UsecaseWithParams<void, CreateBookingParams> {
  final IBookingRepository bookingRepository;

  CreateBookingUsecase(this.bookingRepository);

  @override
  Future<Either<Failure, void>> call(CreateBookingParams params) async {
    return await bookingRepository.createBooking(params.booking);
  }
}
