import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/otp_entity.dart';

part 'otp_api_model.g.dart';
// dart run build_runner build -d
@JsonSerializable()
class OtpApiModel extends Equatable {
  final String email;
  final String otp;

  const OtpApiModel({
    required this.email,
    required this.otp,
  });

  factory OtpApiModel.fromJson(Map<String, dynamic> json) =>
      _$OtpApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpApiModelToJson(this);

  // Convert API model to entity
  OtpEntity toEntity() {
    return OtpEntity(
      email: email,
      otp: otp,
    );
  }

  // Convert entity to API model
  factory OtpApiModel.fromEntity(OtpEntity entity) {
    return OtpApiModel(
      email: entity.email,
      otp: entity.otp,
    );
  }

  @override
  List<Object?> get props => [email, otp];
}
