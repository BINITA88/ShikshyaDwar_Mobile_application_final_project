import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';

import '../../register/register_usecase/auth_repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUseCase(tokenSharedPrefs, repository);

    // Register fallback values for mocked objects
    registerFallbackValue(
        LoginParams(email: 'binita@gmail.com', password: 'binita@123'));
  });

  test('should return a token when login is successful', () async {
    const email = 'testUser';
    const password = 'testPass';
    const token = 'mock_token';
    final loginParams = LoginParams(email: email, password: password);

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((_) async => Right(token));

    when(() => tokenSharedPrefs.saveToken(any()))
        .thenAnswer((_) async => Right(null));

    when(() => tokenSharedPrefs.getToken())
        .thenAnswer((_) async => Future.value(Right(token)));

    final result = await useCase(loginParams);

    expect(result, Right(token));

    verify(() => repository.loginUser(email, password)).called(1);
    verify(() => tokenSharedPrefs.saveToken(token)).called(1);
    verify(() => tokenSharedPrefs.getToken()).called(1);
  });

  test('should return a failure when login fails', () async {
    const username = 'wrongUser';
    const password = 'wrongPass';
    final loginParams = LoginParams(email: username, password: password);

    when(() => repository.loginUser(any(), any()))
        .thenAnswer((_) async => Left(ApiFailure(message: "Invalid login")));

    final result = await useCase(loginParams);

    expect(result, Left(ApiFailure(message: "Invalid login")));

    verify(() => repository.loginUser(username, password)).called(1);
    verifyNever(() => tokenSharedPrefs.saveToken(any()));
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
