// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';

// class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
//     implements LoginBloc {}

// class FakeLoginEvent extends Fake implements LoginEvent {}

// class FakeLoginState extends Fake implements LoginState {}

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   late MockLoginBloc loginBloc;

//   setUpAll(() {
//     registerFallbackValue(FakeLoginEvent());
//     registerFallbackValue(FakeLoginState());
//   });

//   setUp(() {
//     loginBloc = MockLoginBloc();
//   });

//   Widget loadLoginView() {
//     return BlocProvider<LoginBloc>(
//       create: (context) => loginBloc,
//       child: const MaterialApp(
//         home: LoginView(),
//       ),
//     );
//   }

//   testWidgets('1️⃣ Checking for the presence of the Login button',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
//   });

//   testWidgets('2️⃣ Checking for the presence of the Register button',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     expect(find.text('Register'), findsOneWidget);
//   });

//   testWidgets('3️⃣ Validating empty fields show error messages',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//     await tester.pumpAndSettle();

//     expect(find.text('Please enter Email'), findsOneWidget);
//     expect(find.text('Please enter Password'), findsOneWidget);
//   });

//   testWidgets('4️⃣ Entering email and password updates the fields',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());

//     await tester.enterText(find.byType(TextField).at(0), 'Sam11@gmail.com');
//     await tester.enterText(find.byType(TextField).at(1), 'Sam@123');
//     await tester.pump();

//     expect(find.text('Sam11@gmail.com'), findsOneWidget);
//     expect(find.text('Sam@123'), findsOneWidget);
//   });

//   testWidgets('5️⃣ Successful login should trigger navigation', (tester) async {
//     when(() => loginBloc.state).thenReturn(
//       LoginState(
//         isLoading: false,
//         isSuccess: true,
//         user: null,
//         isOtpSent: false,
//         isPasswordReset: false,
//       ),
//     );

//     await tester.pumpWidget(loadLoginView());
//     await tester.enterText(find.byType(TextField).at(0), 'Sam11@gmail.com');
//     await tester.enterText(find.byType(TextField).at(1), 'Sam@123');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//     await tester.pumpAndSettle();

//     verify(() => loginBloc.add(any())).called(1);
//     expect(loginBloc.state.isSuccess, true);
//   });

//   testWidgets('6️⃣ Failed login should display an error message',
//       (tester) async {
//     when(() => loginBloc.state).thenReturn(
//       LoginState(
//         isLoading: false,
//         isSuccess: false,
//         errorMessage: "Invalid credentials",
//         isOtpSent: false,
//         isPasswordReset: false,
//       ),
//     );

//     await tester.pumpWidget(loadLoginView());
//     await tester.enterText(find.byType(TextField).at(0), 'wrong@gmail.com');
//     await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//     await tester.pumpAndSettle();

//     expect(find.text('Invalid credentials'), findsOneWidget);
//   });

//   testWidgets('7️⃣ Checking the Forgot Password button shows modal',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     await tester.tap(find.text('Forgot Password?'));
//     await tester.pumpAndSettle();
//     expect(find.text("Enter email or phone"), findsOneWidget);
//   });

//   testWidgets('8️⃣ Forgot password modal allows OTP request', (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     await tester.tap(find.text('Forgot Password?'));
//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextField).at(0), 'test@gmail.com');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Send OTP'));
//     await tester.pumpAndSettle();

//     verify(() => loginBloc.add(any())).called(1);
//   });

//   testWidgets('9️⃣ Fingerprint authentication button is present and clickable',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     final fingerprintButton =
//         find.widgetWithText(ElevatedButton, 'Login with Fingerprint');
//     expect(fingerprintButton, findsOneWidget);
//     await tester.tap(fingerprintButton);
//     await tester.pumpAndSettle();
//   });

//   testWidgets(
//       '🔟 Fingerprint authentication failure should show an error message',
//       (tester) async {
//     when(() => loginBloc.state).thenReturn(
//       LoginState(
//         isLoading: false,
//         isSuccess: false,
//         isOtpSent: false,
//         isPasswordReset: false,
//       ),
//     );

//     await tester.pumpWidget(loadLoginView());
//     await tester.tap(find.byIcon(Icons.fingerprint));
//     await tester.pumpAndSettle();

//     expect(find.text("Fingerprint authentication failed!"), findsOneWidget);
//   });

//   testWidgets('1️⃣1️⃣ Toggle password visibility', (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     final visibilityButton = find.byIcon(Icons.visibility_off);
//     expect(visibilityButton, findsOneWidget);

//     await tester.tap(visibilityButton);
//     await tester.pump();

//     final visibilityIcon = find.byIcon(Icons.visibility);
//     expect(visibilityIcon, findsOneWidget);
//   });

//   testWidgets('1️⃣2️⃣ Navigating to Register page on tapping Register',
//       (tester) async {
//     await tester.pumpWidget(loadLoginView());
//     await tester.tap(find.text('Register'));
//     await tester.pumpAndSettle();

//     expect(find.byType(LoginView), findsNothing);
//   });
// }

// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
// import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';

// class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
//     implements LoginBloc {}

// class FakeLoginEvent extends Fake implements LoginEvent {}

// class FakeLoginState extends Fake implements LoginState {}

// void main() {
//   late MockLoginBloc loginBloc;

//   setUpAll(() {
//     registerFallbackValue(FakeLoginEvent());
//     registerFallbackValue(FakeLoginState());
//   });

//   setUp(() {
//     loginBloc = MockLoginBloc();
//   });

//   Widget createTestableWidget() {
//     return BlocProvider<LoginBloc>(
//       create: (context) => loginBloc,
//       child: const MaterialApp(
//         home: LoginView(),
//       ),
//     );
//   }

//   testWidgets('1️⃣ Should display Login button', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
//   });

//   testWidgets('2️⃣ Should display Register button', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     expect(find.text('Register'), findsOneWidget);
//   });

//   testWidgets('3️⃣ Empty fields should show validation errors', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//     await tester.pumpAndSettle();

//     expect(find.text('Please enter Email'), findsOneWidget);
//     expect(find.text('Please enter Password'), findsOneWidget);
//   });

//   testWidgets('4️⃣ Entering email and password updates fields', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     await tester.enterText(find.byType(TextField).at(0), 'test@gmail.com');
//     await tester.enterText(find.byType(TextField).at(1), 'Test@123');
//     await tester.pump();

//     expect(find.text('test@gmail.com'), findsOneWidget);
//     expect(find.text('Test@123'), findsOneWidget);
//   });

//   testWidgets('5️⃣ Successful login should navigate to HomeView',
//       (tester) async {
//     whenListen(
//       loginBloc,
//       Stream.fromIterable([
//         LoginState.initial(),
//         LoginState(
//             isLoading: false,
//             isSuccess: true,
//             user: null,
//             isOtpSent: false,
//             isPasswordReset: false),
//       ]),
//     );

//     await tester.pumpWidget(createTestableWidget());

//     await tester.enterText(find.byType(TextField).at(0), 'Sam11@gmail.com');
//     await tester.enterText(find.byType(TextField).at(1), 'Sam@123');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//     await tester.pumpAndSettle();

//     verify(() => loginBloc.add(any<LoginUserEvent>())).called(1);
//   });

//   testWidgets('6️⃣ Failed login should show an error message', (tester) async {
//     whenListen(
//       loginBloc,
//       Stream.fromIterable([
//         LoginState.initial(),
//         LoginState(
//             isLoading: false,
//             isSuccess: false,
//             errorMessage: "Invalid credentials",
//             isOtpSent: false,
//             isPasswordReset: false),
//       ]),
//     );

//     await tester.pumpWidget(createTestableWidget());
//     await tester.enterText(find.byType(TextField).at(0), 'wrong@gmail.com');
//     await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
//     await tester.pumpAndSettle();

//     expect(find.text('Invalid credentials'), findsOneWidget);
//   });

//   testWidgets('7️⃣ Forgot Password button should show modal', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     await tester.tap(find.text('Forgot Password?'));
//     await tester.pumpAndSettle();

//     expect(find.text("Enter email or phone"), findsOneWidget);
//   });

//   testWidgets('8️⃣ Forgot Password modal allows OTP request', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     await tester.tap(find.text('Forgot Password?'));
//     await tester.pumpAndSettle();
//     await tester.enterText(find.byType(TextField).first, 'test@gmail.com');
//     await tester.tap(find.widgetWithText(ElevatedButton, 'Send OTP'));
//     await tester.pumpAndSettle();

//     verify(() => loginBloc.add(any<ForgotPasswordRequested>())).called(1);
//   });

//   testWidgets('9️⃣ Fingerprint authentication button is clickable',
//       (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     final fingerprintButton =
//         find.widgetWithText(ElevatedButton, 'Login with Fingerprint');
//     expect(fingerprintButton, findsOneWidget);
//     await tester.tap(fingerprintButton);
//     await tester.pumpAndSettle();
//   });

//   testWidgets('🔟 Fingerprint authentication failure should show an error',
//       (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState(
//         isLoading: false,
//         isSuccess: false,
//         isPasswordReset: false,
//         isOtpSent: false));
//     await tester.pumpWidget(createTestableWidget());

//     await tester.tap(find.byIcon(Icons.fingerprint));
//     await tester.pumpAndSettle();

//     expect(find.text("Fingerprint authentication failed!"), findsOneWidget);
//   });

//   testWidgets('1️⃣1️⃣ Password visibility toggles correctly', (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     final visibilityButton = find.byIcon(Icons.visibility_off);
//     expect(visibilityButton, findsOneWidget);

//     await tester.tap(visibilityButton);
//     await tester.pump();

//     final visibilityIcon = find.byIcon(Icons.visibility);
//     expect(visibilityIcon, findsOneWidget);
//   });

//   testWidgets('1️⃣2️⃣ Navigating to Register page on tapping Register',
//       (tester) async {
//     when(() => loginBloc.state).thenReturn(LoginState.initial());
//     await tester.pumpWidget(createTestableWidget());

//     await tester.tap(find.text('Register'));
//     await tester.pumpAndSettle();

//     expect(find.byType(LoginView), findsNothing);
//   });
// }

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_event.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/login/login_state.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

class FakeLoginEvent extends Fake implements LoginEvent {}

class FakeLoginState extends Fake implements LoginState {}

class FakeForgotPasswordRequested extends Fake
    implements ForgotPasswordRequested {}

void main() {
  late MockLoginBloc loginBloc;

  setUpAll(() {
    registerFallbackValue(FakeLoginEvent());
    registerFallbackValue(FakeLoginState());
    registerFallbackValue(FakeForgotPasswordRequested()); // Fix issue 2
  });

  setUp(() {
    loginBloc = MockLoginBloc();
    when(() => loginBloc.state).thenReturn(LoginState.initial());
    when(() => loginBloc.stream)
        .thenAnswer((_) => Stream.value(LoginState.initial()));
  });

  Widget createTestableWidget() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: const MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets('1️⃣ Should display Login button', (tester) async {
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  testWidgets('2️⃣ Should display Register button', (tester) async {
    await tester.pumpWidget(createTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text('Register'), findsOneWidget);
  });

  testWidgets('3️⃣ Empty fields should show validation errors', (tester) async {
    await tester.pumpWidget(createTestableWidget());
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter Email'), findsOneWidget);
    expect(find.text('Please enter Password'), findsOneWidget);
  });

  testWidgets('4️⃣ Entering email and password updates fields', (tester) async {
    await tester.pumpWidget(createTestableWidget());

    await tester.enterText(find.byType(TextField).at(0), 'test@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'Test@123');
    await tester.pumpAndSettle();

    expect(find.text('test@gmail.com'), findsOneWidget);
    expect(find.text('Test@123'), findsOneWidget);
  });

  testWidgets('5️⃣ Successful login should navigate to HomeView',
      (tester) async {
    whenListen(
      loginBloc,
      Stream.fromIterable([
        LoginState.initial(),
        LoginState(
            isLoading: false,
            isSuccess: true,
            user: null,
            isOtpSent: false,
            isPasswordReset: false),
      ]),
    );

    await tester.pumpWidget(createTestableWidget());

    await tester.enterText(find.byType(TextField).at(0), 'Sam11@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'Sam@123');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    verify(() => loginBloc.add(any<LoginUserEvent>())).called(1);
  });

  testWidgets('6️⃣ Failed login should show an error message', (tester) async {
    whenListen(
      loginBloc,
      Stream.fromIterable([
        LoginState.initial(),
        LoginState(
            isLoading: false,
            isSuccess: false,
            errorMessage: "Invalid credentials",
            isOtpSent: false,
            isPasswordReset: false),
      ]),
    );

    await tester.pumpWidget(createTestableWidget());
    await tester.enterText(find.byType(TextField).at(0), 'wrong@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('7️⃣ Forgot Password button should show modal', (tester) async {
    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    expect(find.text("Enter email or phone"), findsOneWidget);
  });

  testWidgets('8️⃣ Forgot Password modal allows OTP request', (tester) async {
    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Sam11@gmail.com');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Send OTP'));
    await tester.pumpAndSettle();

    verify(() => loginBloc.add(any<ForgotPasswordRequested>())).called(1);
  });

  testWidgets('9️⃣ Fingerprint authentication button is clickable',
      (tester) async {
    await tester.pumpWidget(createTestableWidget());

    final fingerprintButton =
        find.widgetWithText(ElevatedButton, 'Login with Fingerprint');
    expect(fingerprintButton, findsOneWidget);
    await tester.tap(fingerprintButton);
    await tester.pumpAndSettle();
  });

  // testWidgets('🔟 Fingerprint authentication failure should show an error',
  //     (tester) async {
  //   when(() => loginBloc.state).thenReturn(LoginState(
  //       isLoading: false,
  //       isSuccess: false,
  //       isOtpSent: false,
  //       isPasswordReset: false));
  //   await tester.pumpWidget(createTestableWidget());

  //   await tester.tap(find.byIcon(Icons.fingerprint));
  //   await tester.pumpAndSettle();

  //   expect(find.text("Fingerprint authentication failed!"), findsOneWidget);
  // });

  testWidgets('1️⃣1️⃣ Password visibility toggles correctly', (tester) async {
    await tester.pumpWidget(createTestableWidget());

    final visibilityButton = find.byIcon(Icons.visibility_off);
    expect(visibilityButton, findsOneWidget);

    await tester.tap(visibilityButton);
    await tester.pump();

    final visibilityIcon = find.byIcon(Icons.visibility);
    expect(visibilityIcon, findsOneWidget);
  });

  testWidgets('1️⃣2️⃣ Navigating to Register page on tapping Register',
      (tester) async {
    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginView), findsNothing);
  });
}
