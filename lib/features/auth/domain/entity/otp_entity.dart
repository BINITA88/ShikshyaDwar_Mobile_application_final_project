import 'package:equatable/equatable.dart';

class OtpEntity extends Equatable {
  final String email;
  final String otp;

  const OtpEntity({required this.email, required this.otp});

  @override
  List<Object?> get props => [
        email,
        otp, // Ensure OTP is included in the equality comparison
      ];
}
