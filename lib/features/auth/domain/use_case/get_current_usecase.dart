import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements UsecaseWithoutParams<AuthEntity> {
  final IAuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  @override
  Future<Either<Failure, AuthEntity>> call() {
    return _repository.getMe();
  }
}
