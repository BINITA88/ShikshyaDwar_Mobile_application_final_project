import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/otp_entity.dart';

abstract interface class IOtpRepository {
  Future<Either<Failure, void>> sendAndVerifyOTP(OtpEntity otpEntity);
}
