// // import 'package:equatable/equatable.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// // import 'package:shikshyadwar_mobile_application_project/features/course/presentation/view_model/course_bloc.dart';

// // part 'login_event.dart';
// // part 'login_state.dart';

// // class LoginBloc extends Bloc<LoginEvent, LoginState> {
// //   final RegisterBloc _registerBloc;
// //   final CourseBloc _courseBloc;
// //   final LoginUseCase _loginUseCase;

// //   LoginBloc({
// //     required RegisterBloc registerBloc,
// //     required LoginUseCase loginUseCase,
// //     required CourseBloc courseBloc,
// //   })  : _registerBloc = registerBloc,
// //         _courseBloc = courseBloc,
// //         _loginUseCase = loginUseCase,
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
// //             value: _courseBloc,
// //             child: event.destination,
// //           ),
// //         ),
// //       );
// //     });

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

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final RegisterBloc _registerBloc;
//   final HomeCubit _homeCubit;
//   final LoginUseCase _loginUseCase;
//   final GetCurrentUserUseCase _getCurrentUserUseCase;

//   LoginBloc(
//       {required RegisterBloc registerBloc,
//       required HomeCubit homeCubit,
//       required LoginUseCase loginUseCase,
//       required GetCurrentUserUseCase getCurrentUserUseCase})
//       : _registerBloc = registerBloc,
//         _homeCubit = homeCubit,
//         _loginUseCase = loginUseCase,
//         _getCurrentUserUseCase = getCurrentUserUseCase,
//         super(LoginState.initial()) {
//     on<NavigateRegisterScreenEvent>((event, emit) {
//       Navigator.push(
//         event.context,
//         MaterialPageRoute(
//           builder: (context) => MultiBlocProvider(
//             providers: [
//               BlocProvider.value(value: _registerBloc),
//             ],
//             child: event.destination,
//           ),
//         ),
//       );
//     });

//     on<NavigateHomeScreenEvent>((event, emit) {
//       Navigator.pushReplacement(
//         event.context,
//         MaterialPageRoute(
//           builder: (context) => BlocProvider.value(
//             value: _homeCubit,
//             child: event.destination,
//           ),
//         ),
//       );
//     });

// // /// 🔹 Navigate to Home Screen
// //   void _onNavigateHomeScreen(
// //       NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
// //     Navigator.pushReplacement(
// //       event.context,
// //       MaterialPageRoute(
// //         builder: (context) => BlocProvider.value(
// //           value: _homeCubit,
// //           child: event.destination,
// //         ),
// //       ),
// //     );
// //   }

//     /// 🔹 Fetch Logged-in User Info
//     Future<void> _onGetUserInfo(
//         GetUserInfoEvent event, Emitter<LoginState> emit) async {
//       emit(state.copyWith(isLoading: true));

//       final result = await _getCurrentUserUseCase();

//       result.fold(
//         (failure) {
//           print("Error fetching user info: ${failure.message}");
//           emit(state.copyWith(isLoading: false));
//         },
//         (user) {
//           print(
//               "User fetched successfully: ${user.name}, ${user.email},${user.image}");
//           emit(state.copyWith(isLoading: false, user: user));
//         },
//       );
//     }

//     /// 🔹 Navigate to Register Screen
//     void _onNavigateRegisterScreen(
//         NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
//       Navigator.push(
//         event.context,
//         MaterialPageRoute(
//           builder: (context) => MultiBlocProvider(
//             providers: [BlocProvider.value(value: _registerBloc)],
//             child: event.destination,
//           ),
//         ),
//       );
//     }

//     // Handle login event
//     on<LoginStudentEvent>((event, emit) async {
//       emit(state.copyWith(isLoading: true));

//       final params = LoginParams(
//         email: event.email,
//         password: event.password,
//       );

//       final result = await _loginUseCase.call(params);

//       result.fold(
//         (failure) {
//           // Handle failure (update the state with error message or show a failure alert)
//           emit(state.copyWith(isLoading: false, isSuccess: false));
//         },
//         (student) {
//           // On success, update state and navigate to the home screen
//           emit(state.copyWith(isLoading: false, isSuccess: true));
//         },
//       );
//     });
//   }
// }
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/snackbar/my_snackbar.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/entity/auth_entity';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_current_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view/home_view.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  // final UpdateUserUsecase _updateUserUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;

  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    // required UpdateUserUsecase updateUserUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase,
        // _updateUserUseCase = updateUserUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(_onNavigateRegisterScreen);
    on<NavigateHomeScreenEvent>(_onNavigateHomeScreen);
    on<LoginUserEvent>(_onLoginUser);
    on<GetUserInfoEvent>(_onGetUserInfo);
    // on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    // on<UpdateProfilePictureEvent>(_onUpdateProfilePicture);
  }

  /// 🔹 Navigate to Register Screen
  void _onNavigateRegisterScreen(
      NavigateRegisterScreenEvent event, Emitter<LoginState> emit) {
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [BlocProvider.value(value: _registerBloc)],
          child: event.destination,
        ),
      ),
    );
  }

  /// 🔹 Navigate to Home Screen
  void _onNavigateHomeScreen(
      NavigateHomeScreenEvent event, Emitter<LoginState> emit) {
    Navigator.pushReplacement(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _homeCubit,
          child: event.destination,
        ),
      ),
    );
  }

  /// 🔹 Handle Login
  Future<void> _onLoginUser(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: "Invalid Credentials",
          color: Colors.red,
        );
      },
      (token) async {
        emit(state.copyWith(isLoading: false, isSuccess: true, ));
        showMySnackBar(
          context: event.context,
          message: "Login Successful",
          color: Colors.green,
        );

        // ✅ Save Token to SharedPreferences
        await _tokenSharedPrefs.saveToken(token);

        // ✅ Fetch User Info
        add(GetUserInfoEvent(context: event.context));

        // ✅ Redirect to Home Screen
        add(NavigateHomeScreenEvent(
          context: event.context,
          destination: const HomeView(),
        ));
      },
    );
  }

  /// 🔹 Fetch Logged-in User Info
  Future<void> _onGetUserInfo(
      GetUserInfoEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getCurrentUserUseCase();

    result.fold(
      (failure) {
        print("Error fetching user info: ${failure.message}");
        emit(state.copyWith(isLoading: false));
      },
      (user) {
        print("User fetched successfully: ${user.name}, ${user.email}");
        emit(state.copyWith(isLoading: false, user: user));
      },
    );
  }

  // /// 🔹 Handle User Profile Update
  // Future<void> _onUpdateUserProfile(
  //     UpdateUserProfileEvent event, Emitter<LoginState> emit) async {
  //   emit(state.copyWith(isLoading: true));

  //   if (state.user == null) {
  //     emit(state.copyWith(isLoading: false));
  //     showMySnackBar(
  //       context: event.context,
  //       message: "No user data available!",
  //       color: Colors.red,
  //     );
  //     return;
  //   }

  //   // ✅ Retrieve token before making API call
  //   final tokenResult = await _tokenSharedPrefs.getToken();
  //   final token = tokenResult.fold((failure) => null, (token) => token);

  //   if (token == null) {
  //     emit(state.copyWith(isLoading: false));
  //     showMySnackBar(
  //       context: event.context,
  //       message: "Authentication failed. Please log in again.",
  //       color: Colors.red,
  //     );
  //     return;
  //   }

  //   final updatedUser = state.user!.copyWith(
  //     name: event.name,
  //     bio: event.bio,
  //   );

  //   final result = await _updateUserUseCase(UpdateUserParams(entity: updatedUser));

  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(isLoading: false));
  //       showMySnackBar(
  //         context: event.context,
  //         message: "Profile update failed: ${failure.message}",
  //         color: Colors.red,
  //       );
  //     },
  //     (_) {
  //       emit(state.copyWith(isLoading: false, user: updatedUser));
  //       showMySnackBar(
  //         context: event.context,
  //         message: "Profile updated successfully!",
  //         color: Colors.green,
  //       );
  //     },
  //   );
  // }

  // /// 🔹 Handle Profile Picture Update
  // Future<void> _onUpdateProfilePicture(
  //     UpdateProfilePictureEvent event, Emitter<LoginState> emit) async {
  //   emit(state.copyWith(isLoading: true));

  //   // Simulating API call for profile picture update
  //   await Future.delayed(const Duration(seconds: 2));

  //   const newProfilePictureUrl = "https://your-cloudinary-url.com/new-image.jpg";

  //   final updatedUser = state.user?.copyWith(profilePicture: newProfilePictureUrl);

  //   emit(state.copyWith(isLoading: false, user: updatedUser));

  //   showMySnackBar(
  //     context: event.context,
  //     message: "Profile picture updated successfully!",
  //     color: Colors.green,
  //   );
  // }
}
