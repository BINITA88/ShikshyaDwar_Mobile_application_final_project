// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

// part 'auth_api_model.g.dart';

// @JsonSerializable()
// class AuthApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? authId;
//   final String email;
//   final String? image;
//   @JsonKey(name: 'contact_no')
//   final String contactNo;
//   final String name;
//   final String password;
//   final String? otp; // Optional OTP field

//   const AuthApiModel({
//     this.authId,
//     required this.email,
//     this.image,
//     required this.contactNo,
//     required this.name,
//     required this.password,
//     this.otp, // Optional OTP field
//   });

//   factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
//       _$AuthApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

//   // To Entity
//   AuthEntity toEntity() {
//     return AuthEntity(
//       email: email,
//       contactNo: contactNo,
//       name: name,
//       password: password,
//       image: image,
//       otp: otp, // Ensure OTP is passed to the entity
//     );
//   }

//   // From Entity
//   factory AuthApiModel.fromEntity(AuthEntity entity) {
//     return AuthApiModel(
//         name: entity.name,
//         password: entity.password,
//         email: entity.email,
//         contactNo: entity.contactNo,
//         image: entity.image,
//         otp: entity.otp); // Ensure OTP is handled here as well
//   }

//   @override
//   List<Object?> get props =>
//       [authId, email, image, contactNo, name, password, otp];
// }



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
  final String? otp;
  final int role; // ✅ Added role field (0 = Student, 2 = Instructor)

  const AuthApiModel({
    this.authId,
    required this.email,
    this.image,
    required this.contactNo,
    required this.name,
    required this.password,
    this.otp,
    required this.role, // ✅ Ensure role is included
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // ✅ Convert API Model to Entity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      email: email,
      contactNo: contactNo,
      name: name,
      password: password,
      image: image,
      otp: otp, role: role,
 // ✅ Ensure role is passed to entity
    );
  }

  // ✅ Convert Entity to API Model
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      authId: entity.authId,
      name: entity.name,
      password: entity.password,
      email: entity.email,
      contactNo: entity.contactNo,
      image: entity.image,
      otp: entity.otp, role: entity.role,
      // role: entity.role, // ✅ Ensure role is handled here
    );
  }

  @override
  List<Object?> get props =>
      [authId, email, image, contactNo, name, password, otp, role]; // ✅ Include role in props
}
