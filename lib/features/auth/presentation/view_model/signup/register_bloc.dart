// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_ticket_booking/core/common/snackbar/my_snackbar.dart';
// import 'package:movie_ticket_booking/features/auth/domain/use_case/register_user_usecase.dart';
// import 'package:movie_ticket_booking/features/auth/presentation/view_model/login/login_bloc.dart';

// part 'register_event.dart';
// part 'register_state.dart';

// class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//   // final LoginBloc _loginBloc;
//   final RegisterUseCase _registerUseCase;

//   RegisterBloc({
//     required LoginBloc loginBloc,
//     required RegisterUseCase registerUsecase, required Object registerUseCase,
//   })  :
//         // _loginBloc = loginBloc,
//         _registerUseCase = registerUsecase,
//         super(RegisterState.initial()) {
//     // on<NavigateLoginScreenEvent>((event, emit) {
//     //   Navigator.push(
//     //       event.context,
//     //       MaterialPageRoute(
//     //           builder: (context) => BlocProvider.value(
//     //                 value: _loginBloc,
//     //                 child: event.destination,
//     //               )));
//     // });

//     on<RegisterUserEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true));
//       final result = await _registerUseCase(
//         RegisterUserParams(
//           fullName: event.full_name,
//           email: event.email,
//           contactNo: event.contact_no,
//           username: event.username,
//           password: event.password,
//         ),
//       );

//       result.fold(
//         (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
//         (r) {
//           emit(state.copyWith(isLoading: false, isSuccess: true));
//           mySnackBar(
//               context: event.context, message: "Registration Successful");
//         },
//       );
//     });
//   }
// }
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/verify/verify_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final VerifyBloc _verifyBloc;
  final RegisterUseCase _registerUseCase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterBloc(
      {required VerifyBloc verifyBloc,
      required RegisterUseCase registerUseCase,
      required UploadImageUsecase uploadImageUsecase,
      required RegisterUseCase createStudentUsecase})
      : _verifyBloc = verifyBloc,
        _registerUseCase = registerUseCase,
        _uploadImageUsecase = uploadImageUsecase,
        super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUserEvent);
    on<LoadImage>(_onLoadImage);
    on<NavigateVerifyScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _verifyBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });
  }

  void _onRegisterUserEvent(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(
      RegisterUserParams(
          email: event.email,
          contactNo: event.contactNo,
          name: event.name,
          password: event.password,
          image: event.image,
          otp: event.otp, role: 0, 
          
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
            context: event.context, message: "Registration Successful");
      },
    );
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold((l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
        (r) {
      emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
    });
  }
}
