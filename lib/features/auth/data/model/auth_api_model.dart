import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? authId;
  final String email;
  final String? image;
  @JsonKey(name: 'contact_no')
  final String contactNo;
  final String name;
  final String password;
  final String? otp; // Optional OTP field

  const AuthApiModel({
    this.authId,
    required this.email,
    this.image,
    required this.contactNo,
    required this.name,
    required this.password,
    this.otp, // Optional OTP field
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      email: email,
      contactNo: contactNo,
      name: name,
      password: password,
      image: image,
      otp: otp, // Ensure OTP is passed to the entity
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        name: entity.name,
        password: entity.password,
        email: entity.email,
        contactNo: entity.contactNo,
        image: entity.image,
        otp: entity.otp); // Ensure OTP is handled here as well
  }

  @override
  List<Object?> get props =>
      [authId, email, image, contactNo, name, password, otp];
}
