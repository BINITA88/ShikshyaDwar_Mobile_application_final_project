import 'package:equatable/equatable.dart';

class BookingsEntity extends Equatable {
  final String? bookId;
  final String address;
  final String city;
  final String country;
  final String status;
  final Object user;
  final String shift;
  final String classMode;
  final bool interestedInCounseling;

  const BookingsEntity({
    this.bookId,
    required this.address,
    required this.city,
    required this.country,
    required this.status,
    required this.user,
    required this.shift,
    required this.classMode,
    required this.interestedInCounseling,
  });

  @override
  List<Object?> get props => [
        bookId,
        address,
        city,
        country,
        status,
        user,
        shift,
        classMode,
        interestedInCounseling,
      ];

  static BookingsEntity empty() {
    return BookingsEntity(
      address: '',
      city: '',
      country: '',
      status: '',
      user: Object(), // Replace with a suitable default value for user
      shift: '',
      classMode: '',
      interestedInCounseling: false,
    );
  }
}