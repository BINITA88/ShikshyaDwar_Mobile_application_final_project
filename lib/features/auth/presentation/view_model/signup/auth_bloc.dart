import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/app/shared_prefs/token_shared_prefs.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/get_all_users_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/logout_usecase.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenSharedPrefs tokenPrefs;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetAllUsersUseCase getAllUsersUseCase; // ✅ Add GetAllUsersUseCase

  AuthBloc({
    required this.tokenPrefs,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getAllUsersUseCase, // ✅ Inject UseCase
  }) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<GetAllUsersRequested>(
        _onGetAllUsersRequested); // ✅ New Event for Fetching Users
  }

  /// 🔹 Check if User is Already Logged In
  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    final tokenResult = await tokenPrefs.getToken();
    tokenResult.fold(
      (failure) => emit(AuthUnauthenticated()),
      (token) {
        if (token != null && token.isNotEmpty) {
          emit(AuthAuthenticated(token: token));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  /// 🔹 Handle User Login
  Future<void> _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(message: "Invalid Credentials")),
      (token) async {
        await tokenPrefs.saveToken(token);
        emit(AuthAuthenticated(token: token));
      },
    );
  }

  Future<void> _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await logoutUseCase();
    emit(AuthUnauthenticated());
  }

  /// 🔹 Handle Get All Users Request
  Future<void> _onGetAllUsersRequested(
      GetAllUsersRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoadingUsers());
    final result = await getAllUsersUseCase.call();

    result.fold(
      (failure) => emit(AuthUsersFailure(message: failure.toString())),
      (users) => emit(AuthUsersLoaded(users: users)),
    );
  }
}
