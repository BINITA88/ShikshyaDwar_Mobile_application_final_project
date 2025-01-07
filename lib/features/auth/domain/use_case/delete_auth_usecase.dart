import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/student_repository.dart';

class DeleteAuthParams {
  final String studentId;
  const DeleteAuthParams({required this.studentId});

  const DeleteAuthParams.empty() : studentId = '_empty.string';
}

class DeleteAuthUsecase implements UsecaseWithParams<void, DeleteAuthParams> {
  final IStudentRepository studentRepository;

  DeleteAuthUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, void>> call(DeleteAuthParams params) {
    return studentRepository.deleteStudents(params.studentId);
  }
}
