import 'package:flutter/material.dart';

const String uri = 'http://10.0.2.2:4000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 171, 24, 88),
      Color.fromARGB(255, 171, 24, 88),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(9, 134, 21, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 13, 13, 13)!;
  static const unselectedNavBarColor = Colors.black87;
}
