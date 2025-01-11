import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/data/model/course_hive_model.dart';

import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';
import '../../domain/entity/student_entity.dart';
part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId) // Define a unique typeId
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final List<CourseHiveModel>
      courseId; // Storing course IDs as a list of strings

  AuthHiveModel({
    String? studentId,
    required this.email,
    required this.username,
    required this.password,
    required this.courseId,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        username = '',
        email = '',
        password = '',
        courseId = const [];

  // From Entity
  factory AuthHiveModel.fromEntity(StudentEntity entity) {
    return AuthHiveModel(
      studentId: entity.studentId,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      courseId: CourseHiveModel.fromEntityList(entity.courseId),
    );
  }

  // To Entity
  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      username: username,
      email: email,
      password: password,
      courseId: CourseHiveModel.toEntityList(courseId),
    );
  }

  // From Entity List
  static List<AuthHiveModel> fromEntityList(List<StudentEntity> entityList) {
    return entityList
        .map((entity) => AuthHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [studentId, username, email, password, courseId];
}
