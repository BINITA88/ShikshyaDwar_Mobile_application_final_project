import '../entity/payment_entity.dart';
import '../repository/payment_repository.dart';

class ProcessPaymentUseCase {
  final PaymentRepository repository;

  ProcessPaymentUseCase({required this.repository});

  Future<PaymentEntity> call(int amount) async {
    return await repository.processPayment(amount);
  }
}
