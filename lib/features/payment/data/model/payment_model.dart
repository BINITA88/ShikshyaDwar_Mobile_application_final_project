import '../../domain/entity/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({required String clientSecret}) : super(clientSecret: clientSecret);

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(clientSecret: json['client_secret']);
  }
}
