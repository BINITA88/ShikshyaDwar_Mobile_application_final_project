import 'package:equatable/equatable.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/entity/payment_entity.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentEntity paymentEntity;

  PaymentSuccess({required this.paymentEntity});
}

class PaymentError extends PaymentState {
  final String message;

  PaymentError({required this.message});
}
