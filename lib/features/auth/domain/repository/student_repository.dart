import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentRepository {
  Future<Either<Failure, void>> createStudent(StudentEntity studentEntity);
  Future<Either<Failure, List<StudentEntity>>> getAllStudents();
  Future<Either<Failure, void>> deleteStudents(String id);
  Future<Either<Failure, void>> login(String username, String password);
}
