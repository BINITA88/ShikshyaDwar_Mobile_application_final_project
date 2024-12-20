import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/core/common/theme.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/home_view.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/onboarding_screen.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/signup_view.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/splash_view%20copy.dart';
import 'package:shikshyadwar_mobile_application_project/view/dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/signup': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomepageView(),
        '/dashboard': (context) => const Dashboard(),
        '/onboarding': (context) => const OnboardingPage(),
      },
    ),
  );
}
