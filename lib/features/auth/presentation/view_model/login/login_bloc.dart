// // // import 'package:equatable/equatable.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// // // import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// // // import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';

// // // part 'login_event.dart';
// // // part 'login_state.dart';

// // // class LoginBloc extends Bloc<LoginEvent, LoginState> {
// // //   final RegisterBloc _registerBloc;
// // //   final CourseBloc _courseBloc;
// // //   final LoginUseCase _loginUseCase;

// // //   LoginBloc({
// // //     required RegisterBloc registerBloc,
// // //     required LoginUseCase loginUseCase,
// // //     required CourseBloc courseBloc,
// // //   })  : _registerBloc = registerBloc,
// // //         _courseBloc = courseBloc,
// // //         _loginUseCase = loginUseCase,
// // //         super(LoginState.initial()) {
// // //     on<NavigateRegisterScreenEvent>((event, emit) {
// // //       Navigator.push(
// // //         event.context,
// // //         MaterialPageRoute(
// // //           builder: (context) => MultiBlocProvider(
// // //             providers: [
// // //               BlocProvider.value(value: _registerBloc),
// // //             ],
// // //             child: event.destination,
// // //           ),
// // //         ),
// // //       );
// // //     });

// // //     on<NavigateHomeScreenEvent>((event, emit) {
// // //       Navigator.pushReplacement(
// // //         event.context,
// // //         MaterialPageRoute(
// // //           builder: (context) => BlocProvider.value(
// // //             value: _courseBloc,
// // //             child: event.destination,
// // //           ),
// // //         ),
// // //       );
// // //     });

// // //     // Handle login event
// // //     on<LoginStudentEvent>((event, emit) async {
// // //       emit(state.copyWith(isLoading: true));

// // //       final params = LoginParams(
// // //         email: event.email,
// // //         password: event.password,
// // //       );

// // //       final result = await _loginUseCase.call(params);

// // //       result.fold(
// // //         (failure) {
// // //           // Handle failure (update the state with error message or show a failure alert)
// // //           emit(state.copyWith(isLoading: false, isSuccess: false));
// // //         },
// // //         (student) {
// // //           // On success, update state and navigate to the home screen
// // //           emit(state.copyWith(isLoading: false, isSuccess: true));
// // //         },
// // //       );
// // //     });
// // //   }
// // // }

// // import 'package:equatable/equatable.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';

// // part 'login_event.dart';
// // part 'login_state.dart';

// // class LoginBloc extends Bloc<LoginEvent, LoginState> {
// //   final RegisterBloc _registerBloc;
// //   final HomeCubit _homeCubit;
// //   final LoginUseCase _loginUseCase;
// //   final GetCurrentUserUseCase _getCurrentUserUseCase;

// //   LoginBloc(
// //       {required RegisterBloc registerBloc,
// //       required HomeCubit homeCubit,
// //       required LoginUseCase loginUseCase,
// //       required GetCurrentUserUseCase getCurrentUserUseCase})
// //       : _registerBloc = registerBloc,
// //         _homeCubit = homeCubit,
// //         _loginUseCase = loginUseCase,
// //         _getCurrentUserUseCase = getCurrentUserUseCase,
// //         super(LoginState.initial()) {
// //     on<NavigateRegisterScreenEvent>((event, emit) {
// //       Navigator.push(
// //         event.context,
// //         MaterialPageRoute(
// //           builder: (context) => MultiBlocProvider(
// //             providers: [
// //               BlocProvider.value(value: _registerBloc),
// //             ],
// //             child: event.destination,
// //           ),
// //         ),
// //       );
// //     });

// //     on<NavigateHomeScreenEvent>((event, emit) {
// //       Navigator.pushReplacement(
// //         event.context,
// //         MaterialPageRoute(
// //           builder: (context) => BlocProvider.value(
// //             value: _homeCubit,
// //             child: event.destination,
// //           ),
// //         ),
// //       );
// //     });

// // // /// 🔹 Navigate to Home Screen
// // //   void _onNavigateHomeScreen(
// // //       NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
// // //     Navigator.pushReplacement(
// // //       event.context,
// // //       MaterialPageRoute(
// // //         builder: (context) => BlocProvider.value(
// // //           value: _homeCubit,
// // //           child: event.destination,
// // //         ),
// // //       ),
// // //     );
// // //   }

// //     /// 🔹 Fetch Logged-in User Info
// //     Future<void> _onGetUserInfo(
// //         GetUserInfoEvent event, Emitter<LoginState> emit) async {
// //       emit(state.copyWith(isLoading: true));

// //       final result = await _getCurrentUserUseCase();

// //       result.fold(
// //         (failure) {
// //           print("Error fetching user info: ${failure.message}");
// //           emit(state.copyWith(isLoading: false));
// //         },
// //         (user) {
// //           print(
// //               "User fetched successfully: ${user.name}, ${user.email},${user.image}");
// //           emit(state.copyWith(isLoading: false, user: user));
// //         },
// //       );
// //     }

// //     /// 🔹 Navigate to Register Screen
// //     void _onNavigateRegisterScreen(
// //         NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
// //       Navigator.push(
// //         event.context,
// //         MaterialPageRoute(
// //           builder: (context) => MultiBlocProvider(
// //             providers: [BlocProvider.value(value: _registerBloc)],
// //             child: event.destination,
// //           ),
// //         ),
// //       );
// //     }

// //     // Handle login event
// //     on<LoginStudentEvent>((event, emit) async {
// //       emit(state.copyWith(isLoading: true));

// //       final params = LoginParams(
// //         email: event.email,
// //         password: event.password,
// //       );

// //       final result = await _loginUseCase.call(params);

// //       result.fold(
// //         (failure) {
// //           // Handle failure (update the state with error message or show a failure alert)
// //           emit(state.copyWith(isLoading: false, isSuccess: false));
// //         },
// //         (student) {
// //           // On success, update state and navigate to the home screen
// //           emit(state.copyWith(isLoading: false, isSuccess: true));
// //         },
// //       );
// //     });
// //   }
// // }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/forgot_password_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/reset-password_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final RegisterBloc _registerBloc;
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;
//   final GetCurrentUserUseCase _getCurrentUserUseCase;
//   final TokenSharedPrefs _tokenSharedPrefs;
//   final ForgotPasswordUseCase _forgotPasswordUseCase;
//   final ResetPasswordUseCase _resetPasswordUseCase;

//   LoginBloc({
//     required RegisterBloc registerBloc,
//     required HomeCubit homeCubit,
//     required LoginUseCase loginUseCase,
//     required GetCurrentUserUseCase getCurrentUserUseCase,
//     required ForgotPasswordUseCase forgotPasswordUseCase,
//     required ResetPasswordUseCase resetPasswordUseCase,
//     required TokenSharedPrefs tokenSharedPrefs,
//   })  : _registerBloc = registerBloc,
//         _homeCubit = homeCubit,
//   _loginUseCase = loginUseCase,
//         _getCurrentUserUseCase = getCurrentUserUseCase,
//         _forgotPasswordUseCase = forgotPasswordUseCase,
//         _resetPasswordUseCase = resetPasswordUseCase,
//         _tokenSharedPrefs = tokenSharedPrefs,
//         super(LoginState.initial()) {
//      on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
//     on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);
//     on<LoginUserEvent>(_onLoginUser);
//     on<GetUserInfoEvent>(_onGetUserInfo);
//     on<ForgotPasswordRequested>(_onForgotPasswordRequested);
//     on<ResetPasswordRequested>(_onResetPasswordRequested);
//   }

//   /// 🔹 Navigate to Register Screen
//   void _onNavigateRegisterScreen(
//       NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.push(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => MultiBlocProvider(
//           providers: [BlocProvider.value(value: _registerBloc)],
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   /// 🔹 Navigate to Home Screen
//   void _onNavigateHomeScreen(
//       NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
//     Navigator.pushReplacement(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _homeCubit,
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   /// ✅ **Handle Login**
//   Future<void> _onLoginUser(LoginUserEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _loginUseCase(LoginParams(email: event.email, password: event.password));

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, isSuccess: false, errorMessage: "Invalid Credentials"));
//       },
//       (token) async {
//         await _tokenSharedPrefs.saveToken(token);
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//       },
//     );
//   }

//   /// ✅ **Fetch Logged-in User Info**
//   Future<void> _onGetUserInfo(GetUserInfoEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _getCurrentUserUseCase(event.authId);

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, errorMessage: failure.message));
//       },
//       (user) {
//         emit(state.copyWith(isLoading: false, user: user));
//       },
//     );
//   }

//   /// ✅ **Handle Forgot Password Request**
//   Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _forgotPasswordUseCase(ForgotPasswordParams(email: event.email, phone: event.phone));

//     result.fold(
//       (failure) => emit(state.copyWith(isLoading: false, errorMessage: "Failed to send OTP: ${failure.message}")),
//       (_) => emit(state.copyWith(isLoading: false, isOtpSent: true)),
//     );
//   }

//   /// ✅ **Handle Reset Password Request**
//   Future<void> _onResetPasswordRequested(ResetPasswordRequested event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _resetPasswordUseCase(
//       ResetPasswordParams(
//         email: event.emailOrPhone.contains("@") ? event.emailOrPhone : null,
//         phone: event.emailOrPhone.contains("@") ? null : event.emailOrPhone,
//         otp: event.otp,
//         newPassword: event.newPassword,
//       ),
//     );

//     result.fold(
//       (failure) => emit(state.copyWith(isLoading: false, errorMessage: "Failed to reset password: ${failure.message}")),
//       (_) => emit(state.copyWith(isLoading: false, isPasswordReset: true)),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'login_event.dart';
// import 'login_state.dart';

// // Import your actual implementations:
// import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/forgot_password_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/reset-password_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final RegisterBloc _registerBloc;
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;
//   final GetCurrentUserUseCase _getCurrentUserUseCase;
//   final TokenSharedPrefs _tokenSharedPrefs;
//   final ForgotPasswordUseCase _forgotPasswordUseCase;
//   final ResetPasswordUseCase _resetPasswordUseCase;

//   LoginBloc({
//     required RegisterBloc registerBloc,
//     required HomeCubit homeCubit,
//     required LoginUseCase loginUseCase,
//     required GetCurrentUserUseCase getCurrentUserUseCase,
//     required ForgotPasswordUseCase forgotPasswordUseCase,
//     required ResetPasswordUseCase resetPasswordUseCase,
//     required TokenSharedPrefs tokenSharedPrefs,
//   })  : _registerBloc = registerBloc,
//         _homeCubit = homeCubit,
//         _loginUseCase = loginUseCase,
//         _getCurrentUserUseCase = getCurrentUserUseCase,
//         _forgotPasswordUseCase = forgotPasswordUseCase,
//         _resetPasswordUseCase = resetPasswordUseCase,
//         _tokenSharedPrefs = tokenSharedPrefs,
//         super(LoginState.initial()) {
//     on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
//     on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);

//     // Direct navigation in the login handler
//     on<LoginUserEvent>(_onLoginUser);

//     on<ForgotPasswordRequested>(_onForgotPasswordRequested);
//     on<ResetPasswordRequested>(_onResetPasswordRequested);
//   }

//   Future<void> _onLoginUser(LoginUserEvent event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _loginUseCase(
//       LoginParams(email: event.email, password: event.password),
//     );

//     result.fold(
//       (failure) {
//         emit(state.copyWith(
//             isLoading: false, errorMessage: 'Invalid Credentials'));
//       },
//       (token) async {
//         await _tokenSharedPrefs.saveToken(token);
//         // Directly navigate to HomeView using the provided BuildContext
//         Navigator.pushReplacement(
//           event.context,
//           MaterialPageRoute(builder: (_) => const HomeView()),
//         );
//         emit(state.copyWith(isLoading: false, isSuccess: true));
//       },
//     );
//   }

//   Future<void> _onNavigateRegisterScreen(
//       NavigateRegisterScreenEvent event, Emitter<LoginState> emit) async {
//     Navigator.push(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => MultiBlocProvider(
//           providers: [BlocProvider.value(value: _registerBloc)],
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   Future<void> _onNavigateHomeScreen(
//       NavigateHomeScreenEvent event, Emitter<LoginState> emit) async {
//     Navigator.pushReplacement(
//       event.context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _homeCubit,
//           child: event.destination,
//         ),
//       ),
//     );
//   }

//   Future<void> _onForgotPasswordRequested(
//       ForgotPasswordRequested event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _forgotPasswordUseCase(
//         ForgotPasswordParams(email: event.email, phone: event.phone));
//     result.fold(
//       (failure) => emit(state.copyWith(
//           isLoading: false,
//           errorMessage: "Failed to send OTP: ${failure.message}")),
//       (_) => emit(state.copyWith(isLoading: false, isOtpSent: true)),
//     );
//   }

//   Future<void> _onResetPasswordRequested(
//       ResetPasswordRequested event, Emitter<LoginState> emit) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _resetPasswordUseCase(
//       ResetPasswordParams(
//         email: event.emailOrPhone.contains("@") ? event.emailOrPhone : null,
//         phone: event.emailOrPhone.contains("@") ? null : event.emailOrPhone,
//         otp: event.otp,
//         newPassword: event.newPassword,
//       ),
//     );
//     result.fold(
//       (failure) => emit(state.copyWith(
//           isLoading: false,
//           errorMessage: "Failed to reset password: ${failure.message}")),
//       (_) => emit(state.copyWith(isLoading: false, isPasswordReset: true)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

// Import your actual implementations:
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/core/Fingerprint/fingerprint_auth.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/forgot_password_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/reset-password_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final FingerprintAuth _fingerprintAuth; // ✅ Inject Fingerprint Auth

  LoginBloc({
    required LoginUseCase loginUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required FingerprintAuth fingerprintAuth,
  })  : _loginUseCase = loginUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        _forgotPasswordUseCase = forgotPasswordUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _fingerprintAuth = fingerprintAuth,
        super(LoginState.initial()) {
    on<LoginUserEvent>(_onLoginUser);
    on<FingerprintLoginEvent>(
        _onFingerprintLogin); // ✅ Handle fingerprint login
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }
  Future<void> _onLoginUser(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
            isLoading: false, errorMessage: 'Invalid Credentials'));

        // ✅ Show Snackbar for login failure
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Credentials. Please try again."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      },
      (token) async {
        await _tokenSharedPrefs.saveToken(token);

        // ✅ Show Snackbar for successful login
        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text("Login successful!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // ✅ Navigate to HomeView after a slight delay
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (_) => const HomeView(userRole: 0),
            ),
          );
        });

        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }

  /// ✅ **Handle Fingerprint Authentication**
  Future<void> _onFingerprintLogin(
      FingerprintLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    bool isAvailable = await _fingerprintAuth.isBiometricAvailable();
    if (!isAvailable) {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Fingerprint not available"));
      return;
    }

    bool isAuthenticated = await _fingerprintAuth.authenticate();
    if (isAuthenticated) {
      final tokenResult = await _tokenSharedPrefs.getToken();
      tokenResult.fold(
        (failure) => emit(state.copyWith(
            isLoading: false, errorMessage: "No user session found")),
        (token) {
          if (token != null && token.isNotEmpty) {
            Navigator.pushReplacement(
                event.context,
                MaterialPageRoute(
                    builder: (_) => const HomeView(
                          userRole: 0,
                        )));
            emit(state.copyWith(isLoading: false, isSuccess: true));
          } else {
            emit(state.copyWith(isLoading: false, isSuccess: true));
          }
        },
      );
    } else {
      emit(state.copyWith(
          isLoading: false, errorMessage: "Fingerprint authentication failed"));
    }
  }

  Future<void> _onForgotPasswordRequested(
      ForgotPasswordRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _forgotPasswordUseCase(
        ForgotPasswordParams(email: event.email, phone: event.phone));
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: "Failed to send OTP: ${failure.message}")),
      (_) => emit(state.copyWith(isLoading: false, isOtpSent: true)),
    );
  }

  Future<void> _onResetPasswordRequested(
      ResetPasswordRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _resetPasswordUseCase(
      ResetPasswordParams(
        email: event.emailOrPhone.contains("@") ? event.emailOrPhone : null,
        phone: event.emailOrPhone.contains("@") ? null : event.emailOrPhone,
        otp: event.otp,
        newPassword: event.newPassword,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false,
          errorMessage: "Failed to reset password: ${failure.message}")),
      (_) => emit(state.copyWith(isLoading: false, isPasswordReset: true)),
    );
  }
}
