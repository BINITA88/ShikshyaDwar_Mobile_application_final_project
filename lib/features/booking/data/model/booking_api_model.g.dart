// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      bookId: json['_id'] as String?,
      Address: json['Address'] as String?,
      city: json['city'] as String,
      country: json['country'] as String,
      status: json['status'] as String?,
      shift: json['shift'] as String?,
      classMode: json['classMode'] as String?,
      interestedInCounseling: json['interestedInCounseling'] as bool?,
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.bookId,
      'Address': instance.Address,
      'city': instance.city,
      'country': instance.country,
      'status': instance.status,
      'shift': instance.shift,
      'classMode': instance.classMode,
      'interestedInCounseling': instance.interestedInCounseling,
    };
