import 'dart:io';

import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
  Future<List<AuthEntity>> getAllUsers();

  Future<AuthEntity> getMe(); // ✅ Fetch user details from API

  // Future<String> sendAndVerifyOTP(String email, String otp);
}
