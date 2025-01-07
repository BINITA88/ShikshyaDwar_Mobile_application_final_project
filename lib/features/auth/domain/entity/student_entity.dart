import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/batch/domain/entity/batch_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class StudentEntity extends Equatable {
  final String? studentId;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final BatchEntity batchId;
  final List<CourseEntity> courseId;
  final String username;
  final String password;

  const StudentEntity({
    this.studentId,
    required this.lname,
    this.image,
    required this.phone,
    required this.batchId,
    required this.courseId,
    required this.username,
    required this.password,
    required this.fname,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [studentId, username];
}
