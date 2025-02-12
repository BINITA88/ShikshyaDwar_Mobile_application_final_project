// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/core/error/failure.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/domain/use_case/login_usecase.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/home/presentation/view_model/home_cubit.dart';
// import 'package:flutter/widgets.dart';

// // Mock classes
// class MockLoginUseCase extends Mock implements LoginUseCase {}

// class MockHomeCubit extends Mock implements HomeCubit {}

// class MockRegisterBloc extends Mock implements RegisterBloc {}

// void main() {
//   setUpAll(() {
//     registerFallbackValue(const LoginParams(email: '', password: ''));
//   });

//   late LoginBloc loginBloc;
//   late MockLoginUseCase mockLoginUseCase;
//   late MockHomeCubit mockHomeCubit;
//   late MockRegisterBloc mockRegisterBloc;

//   setUp(() {
//     mockLoginUseCase = MockLoginUseCase();
//     mockHomeCubit = MockHomeCubit();
//     mockRegisterBloc = MockRegisterBloc();
//     loginBloc = LoginBloc(
//       courseBloc: mockHomeCubit,
//       loginUseCase: mockLoginUseCase,
//       registerBloc: mockRegisterBloc,
//     );
//   });

//   tearDown(() {
//     loginBloc.close();
//   });

//   group('LoginBloc', () {
//     test('emits [LoginLoadingState, LoginSuccessState] on successful login',
//         () async {
//       // Arrange
//       when(() => mockLoginUseCase(any()))
//           .thenAnswer((_) async => const Right("fake_token"));
//       final BuildContext mockContext = MockBuildContext();

//       // Act
//       loginBloc.add(LoginStudentEvent(
//           email: 'test', password: 'password', context: mockContext));

//       // Assert
//       await expectLater(
//         loginBloc.stream,
//         emitsInOrder([
//           isA<LoginState>()
//               .having((state) => state.isLoading, 'isLoading', true),
//           isA<LoginState>()
//               .having((state) => state.isSuccess, 'isSuccess', true),
//         ]),
//       );
//     });

//     test('emits [LoginLoadingState, LoginFailureState] on login failure',
//         () async {
//       // Arrange
//       when(() => mockLoginUseCase(any()))
//           .thenAnswer((_) async => Left(ApiFailure(message: 'Login failed')));
//       final BuildContext mockContext = MockBuildContext();

//       // Act
//       loginBloc.add(LoginStudentEvent(
//           email: 'test', password: 'password', context: mockContext));

//       // Assert
//       await expectLater(
//         loginBloc.stream,
//         emitsInOrder([
//           isA<LoginState>()
//               .having((state) => state.isLoading, 'isLoading', true),
//           isA<LoginState>()
//               .having((state) => state.isSuccess, 'isSuccess', false),
//         ]),
//       );
//     });
//   });
// }

// class MockBuildContext extends Mock implements BuildContext {}
