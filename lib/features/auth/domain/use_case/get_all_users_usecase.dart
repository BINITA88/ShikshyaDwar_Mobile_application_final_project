import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class GetAllUsersUseCase implements UsecaseWithoutParams<List<AuthEntity>> {
  final IAuthRepository _repository;

  GetAllUsersUseCase(this._repository);

  @override
  Future<Either<Failure, List<AuthEntity>>> call() {
    return _repository.getAllUsers();
}
}