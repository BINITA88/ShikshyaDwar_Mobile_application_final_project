import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/otp_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/otp_repository.dart';

// RegisterUserParams: Used to pass the necessary data to register a user
class OtpParams extends Equatable {
  final String email;
  final String otp; // Optional OTP field

  const OtpParams({
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [email, otp];
}

// RegisterUseCase: Use case to register a user
class GetVerifyUsecase implements UsecaseWithParams<void, OtpParams> {
  final IOtpRepository otpRepository;

  GetVerifyUsecase(this.otpRepository);

  @override
  Future<Either<Failure, void>> call(OtpParams params) async {
    // Convert RegisterUserParams to AuthEntity
    final otpEntity = OtpEntity(
      email: params.email,
      otp: params.otp, // Pass the OTP if provided
    );

    // Call the repository to register the user
    return otpRepository.sendAndVerifyOTP(otpEntity);
  }
}
