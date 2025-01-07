import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/data/model/batch_hive_model.dart';
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
  final String fname;

  @HiveField(2)
  final String lname;

  @HiveField(3)
  final String? image;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String username;

  @HiveField(6)
  final String password;

  @HiveField(7)
  final BatchHiveModel batchId; // Storing only the batch ID for simplicity

  @HiveField(8)
  final List<CourseHiveModel>
      courseId; // Storing course IDs as a list of strings

  AuthHiveModel({
    String? studentId,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
    required this.batchId,
    required this.courseId,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : studentId = '',
        fname = '',
        lname = '',
        image = '',
        phone = '',
        username = '',
        password = '',
        batchId = const BatchHiveModel.initial(),
        courseId = const [];

  // From Entity
  factory AuthHiveModel.fromEntity(StudentEntity entity) {
    return AuthHiveModel(
      studentId: entity.studentId,
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      phone: entity.phone,
      username: entity.username,
      password: entity.password,
      batchId: BatchHiveModel.fromEntity(entity.batchId),
      courseId: CourseHiveModel.fromEntityList(entity.courseId),
    );
  }

  // To Entity
  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      fname: fname,
      lname: lname,
      image: image,
      phone: phone,
      username: username,
      password: password,
      batchId: batchId.toEntity(),
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
  List<Object?> get props => [
        studentId,
        fname,
        lname,
        image,
        phone,
        username,
        password,
        batchId,
        courseId
      ];
}
