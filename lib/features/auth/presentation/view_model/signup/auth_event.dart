part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShakeLogoutRequested extends AuthEvent {}

class FingerprintLoginEvent extends AuthEvent {
  final BuildContext context;
  FingerprintLoginEvent({required this.context});
}

/// 🔍 Check if the user is authenticated (Login Persistence)
class AuthCheckRequested extends AuthEvent {}

/// 🔹 Event to Handle User Login
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// 🚪 Event to Handle Logout
class AuthLogoutRequested extends AuthEvent {}

/// 🔹 Event to Fetch All Users (NEW)
class GetAllUsersRequested extends AuthEvent {}
