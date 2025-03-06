import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/entity/payment_entity.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/use_cases/get_stripe_api_key_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/payment/domain/use_cases/proccess_payment_usecase.dart';

import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ProcessPaymentUseCase processPaymentUseCase;
  // final GetStripeApiKeyUseCase getStripeApiKeyUseCase;

  PaymentBloc({
    required this.processPaymentUseCase,
    // required this.getStripeApiKeyUseCase, 
  }) : super(PaymentInitial()) {
    on<ProcessPaymentEvent>((event, emit) async {
      emit(PaymentLoading());
      try {
        final payment = await processPaymentUseCase(event.amount);
        emit(PaymentSuccess(paymentEntity: payment));
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    });

    // on<GetStripeApiKeyEvent>((event, emit) async {
    //   emit(PaymentLoading());
    //   try {
    //     final apiKey = await getStripeApiKeyUseCase();
    //     emit(PaymentSuccess(paymentEntity: PaymentEntity(clientSecret: apiKey)));
    //   } catch (e) {
    //     emit(PaymentError(message: e.toString()));
    //   }
    // });
  }
}
