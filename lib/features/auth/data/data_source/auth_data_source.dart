
import 'dart:io';

import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';



abstract interface class IAuthDataSource {
  Future<String> loginUser(String name, String password);

  Future<void> registerUser(AuthEntity user);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}