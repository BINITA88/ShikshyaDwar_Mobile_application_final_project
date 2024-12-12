import 'package:flutter/material.dart';
import 'package:shikshyadwar_mobile_application_project/view/Home/home_view.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/login_view.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/signup_view.dart';
import 'package:shikshyadwar_mobile_application_project/view/auth/splash_view%20copy.dart';
import 'package:shikshyadwar_mobile_application_project/view/dashboard.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 17, 18, 18),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/signup': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomepageView(),
        '/dashboard': (context) => Dashboard(),
      },
    ),
  );
}
