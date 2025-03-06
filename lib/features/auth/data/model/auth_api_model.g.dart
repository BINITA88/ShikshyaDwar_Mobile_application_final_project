// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      authId: json['_id'] as String?,
      email: json['email'] as String,
      image: json['image'] as String?,
      contactNo: json['contact_no'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      otp: json['otp'] as String?,
      role: json['role'] as int, // ✅ Role now included
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.authId,
      'email': instance.email,
      'image': instance.image,
      'contact_no': instance.contactNo,
      'name': instance.name,
      'password': instance.password,
      'otp': instance.otp,
      'role': instance.role, // ✅ Role now included
    };
