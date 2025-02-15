import 'package:shikshyadwar_mobile_application_project/features/payment/data/data_source/remote_datasource/payment_remte_data_source.dart';

import '../../domain/entity/payment_entity.dart';
import '../../domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaymentEntity> processPayment(int amount) async {
    final clientSecret = await remoteDataSource.processPayment(amount);
    return PaymentEntity(clientSecret: clientSecret);
  }

  @override
  Future<String> getStripeApiKey() async {
    return await remoteDataSource.getStripeApiKey();
  }
}
