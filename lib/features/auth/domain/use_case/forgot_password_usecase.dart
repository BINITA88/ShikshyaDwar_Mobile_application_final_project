import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class ForgotPasswordParams extends Equatable {
  final String? email;
  final String? phone;

  const ForgotPasswordParams({this.email, this.phone});

  @override
  List<Object?> get props => [email, phone];
}

class ForgotPasswordUseCase
    implements UsecaseWithParams<void, ForgotPasswordParams> {
  final IAuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    return await repository.forgotPassword(
      email: params.email,
      phone: params.phone,
);
}
}
