import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view/sign_up_view.dart';
import 'package:shikshyadwar_mobile_application_project/features/auth/presentation/view_model/signup/register_bloc.dart';

class MockRegisterBloc extends Mock implements RegisterBloc {}

void main() {
  late MockRegisterBloc mockRegisterBloc;

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
  });

  Widget createRegisterScreen() {
    return MaterialApp(
      home: BlocProvider<RegisterBloc>.value(
        value: mockRegisterBloc,
        child: const SignUpView(),
      ),
    );
  }

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

  testWidgets('should validate empty fields when tapping register button',
      (tester) async {
    await tester.pumpWidget(createRegisterScreen());

    await tester.tap(find.text('Create Account'));
    await tester.pump();

    expect(find.text('Please enter Username'), findsOneWidget);
    expect(find.text('Please enter Email'), findsOneWidget);
    expect(find.text('Please enter Phone number'), findsOneWidget);
    expect(find.text('Please enter Password'), findsOneWidget);
  });

  testWidgets('should validate invalid email format', (tester) async {
    await tester.pumpWidget(createRegisterScreen());

    await tester.enterText(find.byKey(Key('nameField')), 'Test User');
    await tester.enterText(find.byKey(Key('emailField')), 'invalidemail');
    await tester.enterText(find.byKey(Key('contactNoField')), '9876543210');
    await tester.enterText(find.byKey(Key('passwordField')), 'Test@1234');

    await tester.tap(find.text('Create Account'));
    await tester.pump();

    expect(find.text('Enter a valid email address'), findsOneWidget);
  });

  testWidgets('should call RegisterBloc when form is valid', (tester) async {
    when(() => mockRegisterBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(createRegisterScreen());

    await tester.enterText(find.byKey(Key('nameField')), 'Test User');
    await tester.enterText(
        find.byKey(Key('emailField')), 'testuser@example.com');
    await tester.enterText(find.byKey(Key('contactNoField')), '9876543210');
    await tester.enterText(find.byKey(Key('passwordField')), 'Test@1234');

    await tester.tap(find.text('Create Account'));
    await tester.pump();

    verify(() => mockRegisterBloc.add(any<RegisterUserEvent>())).called(1);
  });
}
