import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';

abstract interface class IBookingRepository {
  Future<Either<Failure, void>> createBooking(BookingsEntity booking);
  
  // Future<Either<Failure, List<BookingsEntity>>> getBookings();
}
