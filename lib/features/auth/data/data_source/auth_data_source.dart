import 'dart:io';

import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<String> uploadProfilePicture(File file);
  Future<List<AuthEntity>> getAllUsers();
  Future<AuthEntity> getMe(String authId); // ✅ Fetch user details from API
// New methods for OTP-based forgot and reset password
  Future<void> forgotPassword({String? email, String? phone});

  Future<void> resetPassword({
    String? email,
    String? phone,
    required String otp,
    required String newPassword,
  });
  // Future<String> sendAndVerifyOTP(String email, String otp);
}
