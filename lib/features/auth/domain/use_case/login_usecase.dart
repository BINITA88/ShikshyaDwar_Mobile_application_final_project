import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';


class LoginParams extends Equatable {
  final String name;
  final String password;

  const LoginParams({
    required this.name,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : name = '',
        password = '';

  @override
  List<Object> get props => [name, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  const LoginUseCase(this.tokenSharedPrefs, this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginUser(params.name, params.password).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (token) {
          tokenSharedPrefs.saveToken(token);
          tokenSharedPrefs.getToken().then((value) {
            print(value);
          });
          return Right(token);
        },
      );
    });
  }
}
