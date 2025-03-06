// import 'dart:io';

// import 'package:dartz/dartz.dart';

// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

// class AuthLocalRepository implements IAuthRepository {
//   final AuthLocalDataSource _authLocalDataSource;

//   AuthLocalRepository(this._authLocalDataSource);

//   @override
//   Future<Either<Failure, AuthEntity>> getCurrentUser() async {
//     try {
//       final currentUser = await _authLocalDataSource.getCurrentUser();
//       return Right(currentUser);
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> registerUser(AuthEntity user) async {
//     try {
//       return Right(_authLocalDataSource.registerUser(user));
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadProfilePicture(File file) async {
//     // TODO: implement uploadProfilePicture
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, String>> loginUser(
//       String email, String password) async {
//     try {
//       final token = await _authLocalDataSource.loginUser(email, password);
//       return (Right(token));
//     } catch (e) {
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> sendAndVerifyOTP(
//       String email, String otp) async {
//     try {
//       final verifiedOtp =
//           await _authLocalDataSource.sendAndVerifyOTP(email, otp);
//       return Right(
//           verifiedOtp); // Ensure the response from _authLocalDataSource is correctly passed
//     } catch (e) {
//       // You can also specify different types of exceptions if needed
//       return Left(LocalDatabaseFailure(message: e.toString()));
//     }
//   }
  
//   @override
//   Future<Either<Failure, List<AuthEntity>>> getAllUsers() {
//     // TODO: implement getAllUsers
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, AuthEntity>> getMe(String authId) {
//     // TODO: implement getMe
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, void>> forgotPassword({String? email, String? phone}) {
//     // TODO: implement forgotPassword
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<Either<Failure, void>> resetPassword({String? email, String? phone, required String otp, required String newPassword}) {
//     // TODO: implement resetPassword
//     throw UnimplementedError();
//   }
  
  
// }
