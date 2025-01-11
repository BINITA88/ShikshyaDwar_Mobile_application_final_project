import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/student_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/student_repository.dart';
import 'package:shikshyadwar_mobile_application_project/features/course/domain/entity/course_entity.dart';

class CreateAuthParams extends Equatable {
  final String? studentId;
  final String fname;
  final String lname;
  final String? image;
  final String phone;
  final List<CourseEntity> courseId;
  final String username;
  final String password;

  const CreateAuthParams({
    this.studentId,
    required this.fname,
    required this.lname,
    this.image,
    required this.phone,
    required this.courseId,
    required this.username,
    required this.password,
  });

  const CreateAuthParams.empty()
      : studentId = null,
        fname = '_empty.string',
        lname = '_empty.string',
        image = null,
        phone = '_empty.string',
        courseId = const [],
        username = '_empty.string',
        password = '_empty.string';

  @override
  List<Object?> get props => [
        studentId,
        fname,
        lname,
        image,
        phone,
        courseId,
        username,
        password
      ];
}

class CreateStudentUsecase
    implements UsecaseWithParams<void, CreateAuthParams> {
  final IStudentRepository studentRepository;

  CreateStudentUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(CreateAuthParams params) async {
    return await studentRepository.createStudent(StudentEntity(
      studentId: params.studentId,
      fname: params.fname,
      lname: params.lname,
      image: params.image,
      phone: params.phone,
      courseId: params.courseId,
      username: params.username,
      password: params.password,
    ));
  }
}
