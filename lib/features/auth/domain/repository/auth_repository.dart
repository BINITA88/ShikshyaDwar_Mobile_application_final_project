import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(String email, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);
  // Future<Either<Failure, bool>> updateUserProfile({
  //   required String userId,
  //   required String name,
  //   required String email,
  //   required String contactNo,
  // });

  Future<Either<Failure, List<AuthEntity>>> getAllUsers();
  Future<Either<Failure, AuthEntity>> getMe(String authId); // ✅ Added getMe()
  Future<Either<Failure, void>> forgotPassword({String? email, String? phone});
  Future<Either<Failure, void>> resetPassword(
      {String? email,
      String? phone,
      required String otp,
      required String newPassword});
  // Future<Either<Failure, String>> sendAndVerifyOTP(String email, String otp);
}
