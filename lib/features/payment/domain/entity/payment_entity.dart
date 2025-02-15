import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String clientSecret;

  const PaymentEntity({required this.clientSecret});

  @override
  List<Object> get props => [clientSecret];
}
