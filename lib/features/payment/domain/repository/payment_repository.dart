import 'package:shikshyadwar_mobile_application_project/features/payment/domain/entity/payment_entity.dart';

abstract class PaymentRepository {
  Future<PaymentEntity> processPayment(int amount);
  Future<String> getStripeApiKey();
}
