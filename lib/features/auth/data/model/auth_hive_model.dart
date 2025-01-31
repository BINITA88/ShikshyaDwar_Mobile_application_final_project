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

  AuthHiveModel({
    String? authId,
    required this.name,
    required this.email,
    required this.password,
  }) : authId = authId ?? const Uuid().v4();

//Initial Constructor
  const AuthHiveModel.initial()
      : authId = '',
        name = '',
        email = '',
        password = '';

// From Entity
  factory AuthHiveModel.fromEntity(AuthEntity authEntity) {
    return AuthHiveModel(
        authId: authEntity.authId,
        name: authEntity.name,
        email: authEntity.email,
        password: authEntity.password);
  }

// To Entity
  AuthEntity toEntity() {
    return AuthEntity(
        authId: authId,
        email: email,
        contactNo: '',
        image: null,
        name: name,
        password: '');
  }

// From Entity List
  static List<AuthHiveModel> fromEntityList(List<AuthEntity> entityList) {
    return entityList
        .map((authEntity) => AuthHiveModel.fromEntity(authEntity))
        .toList();
  }

  @override
  List<Object?> get props => [authId, name];
}
