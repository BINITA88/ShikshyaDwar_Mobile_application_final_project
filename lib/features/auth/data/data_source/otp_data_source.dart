import 'dart:io';

import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/otp_entity.dart';

abstract interface class IOtpDataSource {


  Future<void> sendAndVerifyOTP(OtpEntity otp);



  // Future<String> sendAndVerifyOTP(String email, String otp);
}
