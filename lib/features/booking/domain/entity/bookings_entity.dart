import 'package:equatable/equatable.dart';

class BookingsEntity extends Equatable {
  final String? bookId;
  final String? Address;
  final String city;
  final String country;
  final String? status;
  final String? shift;
  final String? classMode;
  final bool? interestedInCounseling;

  const BookingsEntity({
    this.bookId,
    this.Address,
    required this.city,
    required this.country,
    this.status,
    this.shift,
    this.classMode,
    this.interestedInCounseling,
  });

  @override
  List<Object?> get props => [
        bookId,
        Address,
        city,
        country,
        status,
        shift,
        classMode,
        interestedInCounseling,
      ];

  static BookingsEntity empty() {
    return BookingsEntity(
      Address: '',
      city: '',
      country: '',
      status: '',
      shift: '',
      classMode: '',
      interestedInCounseling: false,
    );
  }
}
