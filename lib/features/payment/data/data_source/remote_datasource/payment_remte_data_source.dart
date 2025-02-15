import 'package:dio/dio.dart';

abstract class PaymentRemoteDataSource {
  Future<String> processPayment(int amount);
  Future<String> getStripeApiKey();
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio dio;

  PaymentRemoteDataSourceImpl({required this.dio});

  @override
  Future<String> processPayment(int amount) async {
    try {
      final response = await dio.post(
        'http://10.0.2.2:9000/api/process/payment',
        data: {'amount': amount},
      );
      return response.data['client_secret'];
    } catch (e) {
      throw Exception('Failed to process payment: $e');
    }
  }

  @override
  Future<String> getStripeApiKey() async {
    try {
      final response = await dio.get('http://10.0.2.2:9000/api/stripeapi');
      return response.data['stripeApiKey'];
    } catch (e) {
      throw Exception('Failed to fetch Stripe API key: $e');
    }
  }
}
