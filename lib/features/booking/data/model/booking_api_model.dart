import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/booking/domain/entity/bookings_entity.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookId;
  final String? Address; // ✅ Changed to lowercase for consistency
  final String city;
  final String country;
  final String? status;
  final String? shift;
  final String? classMode;
  final bool? interestedInCounseling;

  const BookingApiModel({
    this.bookId,
    this.Address,
    required this.city,
    required this.country,
    this.status,
    this.shift,
    this.classMode,
    this.interestedInCounseling,
  });

  /// ✅ **Convert JSON to `BookingApiModel`**
  factory BookingApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingApiModelFromJson(json);

  /// ✅ **Convert `BookingApiModel` to JSON**
  Map<String, dynamic> toJson() => _$BookingApiModelToJson(this);

  /// ✅ **Convert `BookingApiModel` to Entity**
  BookingsEntity toEntity() {
    return BookingsEntity(
      bookId: bookId,
      Address: Address,
      city: city,
      country: country,
      status: status,
      shift: shift,
      classMode: classMode,
      interestedInCounseling: interestedInCounseling ?? false, // ✅ Default to false if null
    );
  }

  /// ✅ **Convert `BookingEntity` to API Model**
  factory BookingApiModel.fromEntity(BookingsEntity entity) {
    return BookingApiModel(
      bookId: entity.bookId,
      Address: entity.Address,
      city: entity.city,
      country: entity.country,
      status: entity.status,
      shift: entity.shift,
      classMode: entity.classMode,
      interestedInCounseling: entity.interestedInCounseling,
    );
  }

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
}
