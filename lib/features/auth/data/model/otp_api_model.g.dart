// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpApiModel _$OtpApiModelFromJson(Map<String, dynamic> json) => OtpApiModel(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$OtpApiModelToJson(OtpApiModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };
