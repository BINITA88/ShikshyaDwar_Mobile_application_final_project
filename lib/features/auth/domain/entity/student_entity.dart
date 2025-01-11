import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class StudentEntity extends Equatable {
  final String? studentId;

  // final String phone;
  final List<CourseEntity> courseId;
  final String username;
  final String email;
  final String password;

  const StudentEntity({
    this.studentId,
    required this.courseId,
    required this.username,
    required this.email,
    required this.password,

  });

  @override
  // TODO: implement props
  List<Object?> get props => [studentId, username];
}
