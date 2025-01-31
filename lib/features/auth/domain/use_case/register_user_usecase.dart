import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';


class RegisterUserParams extends Equatable {
  final String email;
  final String? image;
  final String contactNo;
  final String name;
  final String password;

  const RegisterUserParams({
    required this.email,
    this.image,
    required this.contactNo,
    required this.name,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.email,
    this.image,
    required this.contactNo,
    required this.name,
    required this.password,
  });

  @override
  List<Object?> get props => [email, image, contactNo, name, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      email: params.email,
      image: params.image,
      contactNo: params.contactNo,
      name: params.name,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
