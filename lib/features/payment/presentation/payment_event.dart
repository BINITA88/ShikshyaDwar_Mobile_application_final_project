import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProcessPaymentEvent extends PaymentEvent {
  final int amount;

  ProcessPaymentEvent({required this.amount, required paymentMethodId});
}

class GetStripeApiKeyEvent extends PaymentEvent {}
