import 'package:equatable/equatable.dart';

class ExamSeatEntity extends Equatable {
  final String? examSeatId;
  final String seatNumber;
  final bool booked;

  const ExamSeatEntity({
    this.examSeatId,
    required this.seatNumber,
    required this.booked,
  });

  @override
  List<Object?> get props => [examSeatId, seatNumber, booked];

  // Method to toggle booking status
  ExamSeatEntity toggleBooking() {
    return ExamSeatEntity(
      examSeatId: examSeatId,
      seatNumber: seatNumber,
      booked: !booked, // Toggle booking status
    );
  }
}
