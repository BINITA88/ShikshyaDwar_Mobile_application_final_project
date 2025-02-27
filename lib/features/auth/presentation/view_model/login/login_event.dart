// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';

// sealed class LoginEvent extends Equatable {
//   const LoginEvent();

//   @override
//   List<Object?> get props => [];
// }

// /// ✅ **Navigate to Register Screen**
// class NavigateRegisterScreenEvent extends LoginEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateRegisterScreenEvent({
//     required this.context,
//     required this.destination,
//   });

//   @override
//   List<Object?> get props => [context, destination];
// }

// /// ✅ **Navigate to Home Screen**
// class NavigateHomeScreenEvent extends LoginEvent {
//   final BuildContext context;
//   final Widget destination;

//   const NavigateHomeScreenEvent({
//     required this.context,
//     required this.destination,
//   });

//   @override
//   List<Object?> get props => [context, destination];
// }

// /// ✅ **Handle Login Event**

// /// ✅ **Fetch User Info Event**
// class GetUserInfoEvent extends LoginEvent {
//   final String authId;

//   const GetUserInfoEvent(this.authId);

//   @override
//   List<Object?> get props => [authId];
// }

// /// ✅ **Login User Event**
// class LoginUserEvent extends LoginEvent {
//   final String email;
//   final String password;

//   const LoginUserEvent({required this.email, required this.password});

//   @override
//   List<Object?> get props => [email, password];
// }

// /// ✅ **Forgot Password Event (Send OTP)**
// class ForgotPasswordRequested extends LoginEvent {
//   final String? email;
//   final String? phone;

//   const ForgotPasswordRequested({this.email, this.phone});

//   @override
//   List<Object?> get props => [email, phone];
// }

// /// ✅ **Reset Password Event (Verify OTP & Update Password)**
// class ResetPasswordRequested extends LoginEvent {
//   final String emailOrPhone;
//   final String otp;
//   final String newPassword;

//   const ResetPasswordRequested({
//     required this.emailOrPhone,
//     required this.otp,
//     required this.newPassword,
//   });

//   @override
//   List<Object?> get props => [emailOrPhone, otp, newPassword];
// }
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

/// Navigate to Register Screen
class NavigateRegisterScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}

/// Navigate to Home Screen
class NavigateHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}

/// Login User Event – note we include BuildContext so that the Bloc can navigate directly.
class LoginUserEvent extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  const LoginUserEvent({
    required this.context,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [context, email, password];
}

/// Forgot Password (Send OTP) Event
class ForgotPasswordRequested extends LoginEvent {
  final String? email;
  final String? phone;

  const ForgotPasswordRequested({this.email, this.phone});

  @override
  List<Object?> get props => [email, phone];
}

/// Reset Password (Verify OTP & Update Password) Event
class ResetPasswordRequested extends LoginEvent {
  final String emailOrPhone;
  final String otp;
  final String newPassword;

  const ResetPasswordRequested({
    required this.emailOrPhone,
    required this.otp,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [emailOrPhone, otp, newPassword];
}

class FingerprintLoginEvent extends LoginEvent {
  final BuildContext context;
  const FingerprintLoginEvent({required this.context});
}
