part of 'login_bloc.dart';

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final AuthEntity? user;
  LoginState({
    required this.isLoading,
    required this.isSuccess,
    this.user,
  });

  LoginState.initial()
      : isLoading = false,
        isSuccess = false,
        user = null;

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AuthEntity? user,
  }) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        user: user ?? this.user);
  }
}
