import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateBookingEvent extends BookingEvent {
  final BookingsEntity booking;

  CreateBookingEvent({required this.booking});

  @override
  List<Object?> get props => [booking];
}
