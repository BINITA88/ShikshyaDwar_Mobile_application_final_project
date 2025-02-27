import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/auth_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/auth_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs; // ✅ Add TokenSharedPrefs

  AuthRemoteDatasource(this._dio, this._tokenSharedPrefs);

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
Future<AuthEntity> getMe(String authId) async {
  try {
    if (authId.isEmpty) throw Exception("Invalid auth ID!");

    // ✅ Fetch user details using authId
    Response response = await _dio.get(
      "http://10.0.2.2:9000/api/user/userdetails/$authId", // ✅ Use authId
      options: Options(headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      }),
    );

    print("✅ API Response: ${response.statusCode} - ${response.data}");
    return AuthEntity.fromJson(response.data);
  } on DioException catch (e) {
    print("❌ DioException: ${e.type}");
    print("🔹 Response Data: ${e.response?.data}");
    throw Exception("DioException: ${e.message}");
  } catch (e) {
    throw Exception("Unexpected error: $e");
  }
}

// String extractUserIdFromToken(String token) {
//   try {
//     Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
//     return decodedToken["_id"] ?? ''; // ✅ Extracts the user ID
//   } catch (e) {
//     throw Exception("Invalid JWT Token: $e");
//   }
// }

@override
  Future<void> forgotPassword({String? email, String? phone}) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints
            .forgotPassword, // Ensure this endpoint is defined, e.g. "/api/v1/users/forgot-password"
        data: {
          'email': email,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        return;
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
  Future<void> resetPassword(
      {String? email,
      String? phone,
      required String otp,
      required String newPassword}) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints
            .resetPassword, // Ensure this endpoint is defined, e.g. "/api/v1/users/reset-password"
        data: {
          'email': email,
          'phone': phone,
          'otp': otp,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
}
}
}



