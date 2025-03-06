// import 'package:equatable/equatable.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

// class LoginState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final AuthEntity? user;
//   final bool isOtpSent;
//   final bool isPasswordReset;
//   final String errorMessage;

//   const LoginState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.user,
//     required this.isOtpSent,
//     required this.isPasswordReset,
//     this.errorMessage = "",
//   });

//   /// ✅ **Initial state**
//   factory LoginState.initial() {
//     return const LoginState(
//       isLoading: false,
//       isSuccess: false,
//       user: null,
//       isOtpSent: false,
//       isPasswordReset: false,
//       errorMessage: "",
//     );
//   }

//   /// ✅ **CopyWith method**
//   LoginState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     AuthEntity? user,
//     bool? isOtpSent,
//     bool? isPasswordReset,
//     String? errorMessage,
//   }) {
//     return LoginState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       user: user ?? this.user,
//       isOtpSent: isOtpSent ?? this.isOtpSent,
//       isPasswordReset: isPasswordReset ?? this.isPasswordReset,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, isSuccess, user, isOtpSent, isPasswordReset, errorMessage];
// }

// import 'package:equatable/equatable.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

// class LoginState extends Equatable {
//   final bool isLoading;
//   final bool isSuccess;
//   final AuthEntity? user;
//   final bool isOtpSent;
//   final bool isPasswordReset;
//   final String errorMessage;

//   const LoginState({
//     required this.isLoading,
//     required this.isSuccess,
//     this.user,
//     required this.isOtpSent,
//     required this.isPasswordReset,
//     this.errorMessage = "",
//   });

//   factory LoginState.initial() {
//     return const LoginState(
//       isLoading: false,
//       isSuccess: false,
//       user: null,
//       isOtpSent: false,
//       isPasswordReset: false,
//       errorMessage: "",
//     );
//   }

//   LoginState copyWith({
//     bool? isLoading,
//     bool? isSuccess,
//     AuthEntity? user,
//     bool? isOtpSent,
//     bool? isPasswordReset,
//     String? errorMessage,
//   }) {
//     return LoginState(
//       isLoading: isLoading ?? this.isLoading,
//       isSuccess: isSuccess ?? this.isSuccess,
//       user: user ?? this.user,
//       isOtpSent: isOtpSent ?? this.isOtpSent,
//       isPasswordReset: isPasswordReset ?? this.isPasswordReset,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props =>
//       [isLoading, isSuccess, user, isOtpSent, isPasswordReset, errorMessage];
// }

import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final AuthEntity? user;
  final int? role; // ✅ Add role field
  final bool isOtpSent;
  final bool isPasswordReset;
  final String errorMessage;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.user,
    this.role, // ✅ Include role
    required this.isOtpSent,
    required this.isPasswordReset,
    this.errorMessage = "",
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      isSuccess: false,
      user: null,
      role: null, // ✅ Initialize role as null
      isOtpSent: false,
      isPasswordReset: false,
      errorMessage: "",
    );
  }

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AuthEntity? user,
    int? role, // ✅ Include role in copyWith
    bool? isOtpSent,
    bool? isPasswordReset,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
      role: role ?? this.role, // ✅ Update role when needed
      isOtpSent: isOtpSent ?? this.isOtpSent,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        user,
        role,
        isOtpSent,
        isPasswordReset,
        errorMessage
      ];
}
