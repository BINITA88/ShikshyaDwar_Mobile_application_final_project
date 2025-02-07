import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

// RegisterUserParams: Used to pass the necessary data to register a user
class RegisterUserParams extends Equatable {
  final String email;
  final String? image;
  final String contactNo;
  final String name;
  final String password;
  final String? otp; // Optional OTP field

  const RegisterUserParams({
    required this.email,
    this.image,
    required this.contactNo,
    required this.name,
    required this.password,
    this.otp,
  });

  @override
  List<Object?> get props => [email, image, contactNo, name, password, otp];
}

// RegisterUseCase: Use case to register a user
class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) async {
    // Convert RegisterUserParams to AuthEntity
    final authEntity = AuthEntity(
      email: params.email,
      image: params.image,
      contactNo: params.contactNo,
      name: params.name,
      password: params.password,
      otp: params.otp, // Pass the OTP if provided
    );
    
    // Call the repository to register the user
    return repository.registerUser(authEntity);
  }
}
