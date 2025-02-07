import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/remote_datasource/otp_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/otp_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/otp_repository.dart';

class OtpRemoteRepository implements IOtpRepository {
  final OtpRemoteDatasource _otpRemoteDatasource;

  OtpRemoteRepository(this._otpRemoteDatasource);

  @override
  Future<Either<Failure, void>> sendAndVerifyOTP(OtpEntity otpEntity) async {
    try {
      await _otpRemoteDatasource.sendAndVerifyOTP(otpEntity);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
