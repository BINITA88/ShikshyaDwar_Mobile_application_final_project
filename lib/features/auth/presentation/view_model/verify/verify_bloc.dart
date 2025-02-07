import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_verify_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/verify/verify_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/verify/verify_state.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  
  
  final GetVerifyUsecase _verifyusecase;

  VerifyBloc({required GetVerifyUsecase verifyusecase,})
      : _verifyusecase = verifyusecase,
        super(VerifyState.initial()) {
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
  }

  Future<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<VerifyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _verifyusecase.call(
      OtpParams(
        email: event.email,
        otp: '',
      ),
    );

    result.fold(
      (l) => {
        emit(state.copyWith(isLoading: false, isSuccess: false)),
        showMySnackBar(
            context: event.context, message: l.message, color: Colors.red)
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Email verification Successful");
      },
    );
  }
}
