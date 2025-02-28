// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';

// class MockLoginBloc extends Mock implements LoginBloc {}

// void main() {
//   late MockLoginBloc mockLoginBloc;

//   setUp(() {
//     mockLoginBloc = MockLoginBloc();
//   });

//   Widget createLoginScreen() {
//     return MaterialApp(
//       home: BlocProvider<LoginBloc>.value(
//         value: mockLoginBloc,
//         child: const LoginView(),
//       ),
//     );
//   }

//   testWidgets('should render login view with input fields and button', (tester) async {
//     await tester.pumpWidget(createLoginScreen());

//     expect(find.text('Welcome Back'), findsOneWidget);
//     expect(find.text('Email'), findsOneWidget);
//     expect(find.text('Password'), findsOneWidget);
//     expect(find.text('Login'), findsOneWidget);
//   });

//   testWidgets('should validate empty fields when tapping login button', (tester) async {
//     await tester.pumpWidget(createLoginScreen());

//     await tester.tap(find.text('Login'));
//     await tester.pump();

//     expect(find.text('Please enter Email'), findsOneWidget);
//     expect(find.text('Please enter Password'), findsOneWidget);
//   });

//   testWidgets('should validate password length', (tester) async {
//     await tester.pumpWidget(createLoginScreen());

//     await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
//     await tester.enterText(find.byKey(Key('passwordField')), '123');

//     await tester.tap(find.text('Login'));
//     await tester.pump();

//     expect(find.text('Password must be at least 6 characters long'), findsOneWidget);
//   });

//   testWidgets('should call LoginBloc when form is valid', (tester) async {
//     when(() => mockLoginBloc.add(any())).thenReturn(null);

//     await tester.pumpWidget(createLoginScreen());

//     await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
//     await tester.enterText(find.byKey(Key('passwordField')), 'validpassword');

//     await tester.tap(find.text('Login'));
//     await tester.pump();

//     verify(() => mockLoginBloc.add(any<LoginUserEvent>())).called(1);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/sign_up_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';

/// ✅ Mock Classes for BLoC
class MockLoginBloc extends Mock implements LoginBloc {}

class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginBloc mockLoginBloc;
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    mockRegisterBloc = MockRegisterBloc();
  });

  /// 📌 Create a testable Login screen
  Widget createLoginScreen() {
    return MaterialApp(
      home: BlocProvider<LoginBloc>.value(
        value: mockLoginBloc,
        child: const LoginView(),
      ),
    );
  }

  /// 📌 Create a testable SignUp screen
  Widget createRegisterScreen() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: mockRegisterBloc,
        child: const SignUpView(),
      ),
    );
  }

  /// 🔹 **Test 1: Ensure Login screen UI renders properly**
  testWidgets('should render login view with input fields and buttons',
      (tester) async {
    await tester.pumpWidget(createLoginScreen());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  /// 🔹 **Test 2: Ensure Login form validation works**
  testWidgets('should validate empty email and password', (tester) async {
    await tester.pumpWidget(createLoginScreen());

    await tester.tap(find.text('Login'));
    await tester.pump();

    expect(find.text('Please enter Email'), findsOneWidget);
    expect(find.text('Please enter Password'), findsOneWidget);
  });

  /// 🔹 **Test 3: Ensure correct Login BLoC event is triggered**
  testWidgets('should call LoginBloc when login form is valid', (tester) async {
    when(() => mockLoginBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(createLoginScreen());

    await tester.enterText(
        find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'ValidPass123');

    await tester.tap(find.text('Login'));
    await tester.pump();

    verify(() => mockLoginBloc.add(any())).called(1);
  });

  /// 🔹 **Test 4: Ensure SignUp screen UI renders properly**
  testWidgets('should render register view with input fields and button',
      (tester) async {
    await tester.pumpWidget(createRegisterScreen());

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Create Account'), findsOneWidget);
  });

  /// 🔹 **Test 5: Ensure SignUp form validation works**
  testWidgets('should validate empty sign-up fields', (tester) async {
    await tester.pumpWidget(createRegisterScreen());

    await tester.tap(find.text('Create Account'));
    await tester.pump();

    expect(find.text('Please enter Username'), findsOneWidget);
    expect(find.text('Please enter Email'), findsOneWidget);
    expect(find.text('Please enter Phone number'), findsOneWidget);
    expect(find.text('Please enter Password'), findsOneWidget);
  });

  /// 🔹 **Test 6: Ensure correct Register BLoC event is triggered**
  testWidgets('should call RegisterBloc when register form is valid',
      (tester) async {
    when(() => mockRegisterBloc.add(any<RegisterUserEvent>())).thenReturn(null);

    await tester.pumpWidget(createRegisterScreen());

    await tester.enterText(find.byType(TextFormField).at(0), 'TestUser');
    await tester.enterText(
        find.byType(TextFormField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(2), '9876543210');
    await tester.enterText(find.byType(TextFormField).at(3), 'ValidPass123');

    await tester.tap(find.text('Create Account'));
    await tester.pump();

    verify(() => mockRegisterBloc.add(any<RegisterUserEvent>())).called(1);
  });
}
