import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class VerifyEvent extends Equatable {
  const VerifyEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpEvent extends VerifyEvent {
  final BuildContext context;
  final String email;
  final String? otp;

  const VerifyOtpEvent({
    required this.context,
    required this.email,
    this.otp,
  });
}

// // OTP Verification Event
// class VerifyOtpEvent extends VerifyEvent {
//   final String email;
//   final String otp;
//   final void Function() onSuccess;
//   final void Function(String) onFailure;

//   const VerifyOtpEvent({
//     required this.email,
//     required this.otp,
//     required this.onSuccess,
//     required this.onFailure,
//   });

//   @override
//   List<Object> get props => [email, otp];
// }

class NavigateLoginScreenEvent extends VerifyEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}
