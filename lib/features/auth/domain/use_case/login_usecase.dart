import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : email = '',
        password = '';

  @override
  List<Object> get props => [email, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  const LoginUseCase(this.tokenSharedPrefs, this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginUser(params.email, params.password).then((value) {
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

// import 'dart:convert';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
// import 'package:shikshyadwar_mobile_application_project/app/usecase/usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_response.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/repository/auth_repository.dart';

// class LoginParams extends Equatable {
//   final String email;
//   final String password;

//   const LoginParams({
//     required this.email,
//     required this.password,
//   });

//   @override
//   List<Object> get props => [email, password];
// }

// class LoginUseCase implements UsecaseWithParams<AuthResponse, LoginParams> {
//   final IAuthRepository repository;
//   final TokenSharedPrefs tokenSharedPrefs;

//   const LoginUseCase(this.tokenSharedPrefs, this.repository);

//   @override
//   Future<Either<Failure, AuthResponse>> call(LoginParams params) async {
//     final result = await repository.loginUser(params.email, params.password);

//     return result.fold(
//       (failure) => Left(failure),
//       (authData) async {
//         try {
//           // ✅ Check if the response is a String and decode it
//           final parsedAuthData = authData is String
//               ? jsonDecode(authData)
//               : authData; // Ensure it's a Map

//           if (parsedAuthData is Map<String, dynamic> &&
//               parsedAuthData.containsKey('token') &&
//               parsedAuthData.containsKey('user') &&
//               parsedAuthData['user'] is Map<String, dynamic>) {
//             final String token = parsedAuthData['token'];
//             final int role = parsedAuthData['user']['role']; // Extract role

//             // ✅ Save token and role in shared preferences
//             await tokenSharedPrefs.saveTokenAndRole(token, role);

//             // ✅ Return AuthResponse model
//             return Right(AuthResponse(token: token, role: role));
//           } else {
//             return Left(ApiFailure(message: "Invalid response format"));
//           }
//         } catch (e) {
//           return Left(ApiFailure(
//               message: 'Error parsing login response: ${e.toString()}'));
//         }
//       },
//     );
//   }
// }
