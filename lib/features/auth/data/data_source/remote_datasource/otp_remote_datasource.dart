import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shikshyadwar_mobile_application_project/app/constants/api_endpoints.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/data_source/otp_data_source.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/data/model/otp_api_model.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/otp_entity.dart';

class OtpRemoteDatasource implements IOtpDataSource {
  final Dio _dio;

  OtpRemoteDatasource(this._dio);

  @override
  Future<void> sendAndVerifyOTP(OtpEntity otpEntity) async {
    try {
      // Convert entity to model
      var otpApiModel = OtpApiModel.fromEntity(otpEntity);
      var response = await _dio.post(
        ApiEndpoints.sendotp,
        data: otpApiModel.toJson(),
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
}
