import 'dart:io';

import 'package:shikshyadwar_mobile_application_project/core/network/hive_service.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/auth_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/auth_hive_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
      authId: '1',
      email: '',
      contactNo: '',
      image: null,
      name: '',
      password: '',
      otp: '',
    ));
  }

  @override
  Future<String> loginUser(String name, String password) async {
    try {
      await _hiveService.loginStudent(name, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(user);

      await _hiveService.addStudent(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> sendAndVerifyOTP(String email, String otp) async {
    try {
      await _hiveService.verifyOTP(email, otp);
      return "Success"; // Return a success message instead of Future.value
    } catch (e) {
      throw e; // Re-throw the error so it can be caught in the repository
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }

  @override
  Future<List<AuthEntity>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }
  
  @override
  Future<AuthEntity> getMe(String authId) {
    // TODO: implement getMe
    throw UnimplementedError();
  }
  
  @override
  Future<void> forgotPassword({String? email, String? phone}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }
  
  @override
  Future<void> resetPassword({String? email, String? phone, required String otp, required String newPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
  
 
}
