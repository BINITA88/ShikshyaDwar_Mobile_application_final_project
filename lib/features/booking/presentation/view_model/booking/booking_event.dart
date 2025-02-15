import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';

abstract class BookingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class NavigatePaymentScreenEvent extends BookingEvent {
  final BuildContext context;
  final Widget destination;

   NavigatePaymentScreenEvent({
    required this.context,
    required this.destination,
  });
}

class CreateBookingEvent extends BookingEvent {
  final BookingsEntity booking;

  CreateBookingEvent({required this.booking});

  @override
  List<Object?> get props => [booking];
}
