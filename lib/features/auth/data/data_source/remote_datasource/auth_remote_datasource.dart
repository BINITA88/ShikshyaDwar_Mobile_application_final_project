import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/auth_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/auth_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDatasource(this._dio);

  @override
  Future<void> registerUser(AuthEntity authEntity) async {
    try {
      // Convert entity to model
      var authApiModel = AuthApiModel.fromEntity(authEntity);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: authApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(ApiEndpoints.login, data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> sendAndVerifyOTP(String email, String otp) async {
    try {
      Response response = await _dio.post(ApiEndpoints.sendotp, data: {
        "email": email,
        "otp": otp, // Send OTP for verification
      });

      if (response.statusCode == 200) {
        return response.data["message"] ??
            "OTP verified successfully for $email";
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? e.message);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture':
              await MultipartFile.fromFile(file.path, filename: fileName),
        },
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<AuthEntity>> getAllUsers() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getAllUsers);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data // ✅ Case 1: If API returns a direct list
            : response.data['users'] ??
                []; // ✅ Case 2: If API wraps users in a key

        return data
            .map((item) => AuthEntity.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to fetch users: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data["message"] ?? "Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getCurrentUser);

      if (response.statusCode == 200) {
        // Assuming the response data is a map representing the AuthEntity
        final data = response.data;
        final authEntity = AuthEntity.fromJson(data);
        return authEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getMe() {
    // TODO: implement getMe
    throw UnimplementedError();
  }
}
