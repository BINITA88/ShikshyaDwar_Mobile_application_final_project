import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.amber,
    scaffoldBackgroundColor: const Color.fromARGB(255, 250, 248, 248),
    fontFamily: 'Roboto', // Ensure 'Roboto' is properly set in pubspec.yaml

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 12, // Adjust the font size here
          fontWeight: FontWeight.normal,
          color: Colors.white, // Text color
        ),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        fixedSize: const Size(80, 40), // Button size
        padding: EdgeInsets.zero,
      ),
    ),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Color.fromARGB(255, 12, 51, 82),
      elevation: 4,
      shadowColor: Color.fromARGB(255, 20, 8, 105),
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: Color.fromARGB(255, 247, 246, 246),
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
