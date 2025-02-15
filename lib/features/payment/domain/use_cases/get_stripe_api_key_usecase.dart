import 'package:shikshyadwar_mobile_application_project/features/payment/domain/repository/payment_repository.dart';

class GetStripeApiKeyUseCase {
  final PaymentRepository repository;

  GetStripeApiKeyUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getStripeApiKey();
  }
}
