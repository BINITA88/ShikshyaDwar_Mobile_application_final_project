import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/student_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/student_repository.dart';


class GetAllAuthUsecase implements UsecaseWithoutParams<List<StudentEntity>> {
  final IStudentRepository studentRepository;

  GetAllAuthUsecase(this.studentRepository);

  @override
  Future<Either<Failure, List<StudentEntity>>> call() {
    return studentRepository
        .getAllStudents(); // Assuming 'getAllStudents' exists in the repository
  }
}
