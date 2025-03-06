// import 'package:equatable/equatable.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:shikshyadwar_mobile_application_project/app/constants/hive_table_constant.dart';

// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// import 'package:uuid/uuid.dart';

// part 'auth_hive_model.g.dart';

// @HiveType(typeId: HiveTableConstant.studentTableId)
// class AuthHiveModel extends Equatable {
//   @HiveField(0)
//   final String? authId;

//   @HiveField(1)
//   final String name;

//   @HiveField(2)
//   final String email;

//   @HiveField(3)
//   final String password;

//   @HiveField(4)
//   final String? otp;

//   AuthHiveModel({
//     String? authId,
//     required this.name,
//     required this.email,
//     required this.password,
//     this.otp,
//   }) : authId = authId ?? const Uuid().v4();

// //Initial Constructor
//   const AuthHiveModel.initial()
//       : authId = '',
//         name = '',
//         email = '',
//         password = '',
//         otp = '';

// // From Entity
//   factory AuthHiveModel.fromEntity(AuthEntity authEntity) {
//     return AuthHiveModel(
//       authId: authEntity.authId,
//       name: authEntity.name,
//       email: authEntity.email,
//       password: authEntity.password,
//       otp: authEntity.otp,
//     );
//   }

// // To Entity
//   AuthEntity toEntity() {
//     return AuthEntity(
//       authId: authId,
//       email: email,
//       contactNo: '',
//       image: null,
//       name: name,
//       password: '',
//       otp: otp, role: role,
//     );
//   }

// // From Entity List
//   static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
//     return entityList
//         .map((authEntity) => AuthHiveModel.fromEntity(authEntity))
//         .toList();
//   }

//   @override
//   List<Object?> get props => [authId, name, email, otp];
// }





import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/hive_table_constant.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? authId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String? otp;

  @HiveField(5) // ✅ Add role field in Hive storage
  final int role;

  AuthHiveModel({
    String? authId,
    required this.name,
    required this.email,
    required this.password,
    this.otp,
    required this.role, // ✅ Ensure role is included
  }) : authId = authId ?? const Uuid().v4();

//Initial Constructor
  const AuthHiveModel.initial()
      : authId = '',
        name = '',
        email = '',
        password = '',
        otp = '',
        role = 0; // ✅ Default role (e.g., Student = 0)

// From Entity
  factory AuthHiveModel.fromEntity(AuthEntity authEntity) {
    return AuthHiveModel(
      authId: authEntity.authId,
      name: authEntity.name,
      email: authEntity.email,
      password: authEntity.password,
      otp: authEntity.otp,
      role: authEntity.role, // ✅ Ensure role is passed
    );
  }

// To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      authId: authId,
      email: email,
      contactNo: '',
      image: null,
      name: name,
      password: '',
      otp: otp,
      role: role, // ✅ Ensure role is passed to entity
    );
  }

// From Entity List
  static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList
        .map((authEntity) => AuthHiveModel.fromEntity(authEntity))
        .toList();
  }

  @override
  List<Object?> get props => [authId, name, email, otp, role]; // ✅ Include role
}
