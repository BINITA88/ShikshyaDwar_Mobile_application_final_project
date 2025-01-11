part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class NavigateRegisterScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}

class NavigateHomeScreenEvent extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object?> get props => [context, destination];
}

class LoginStudentEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginStudentEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class NavigateToLoginEvent extends LoginEvent {
  final BuildContext context;

  const NavigateToLoginEvent({
    required this.context,
  });

  @override
  List<Object?> get props => [context];
}
