import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity authEntity) async {
    try {
      await _authRemoteDatasource.registerUser(authEntity);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String name, String password) async {
    try {
      final token = await _authRemoteDatasource.loginUser(name, password);
      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, String>> sendAndVerifyOTP(String email, String otp) async {
  //   try {
  //     final verifiedOtp = await _authRemoteDatasource.sendAndVerifyOTP(
  //         email, otp); // Corrected to use _authRemoteDatasource
  //     return Right(verifiedOtp); // Ensure the response is correctly passed
  //   } catch (e) {
  //     // You can also specify different types of exceptions if needed
  //     return Left(
  //         ApiFailure(message: e.toString())); // Updated to match API failure
  //   }
  // }
}
