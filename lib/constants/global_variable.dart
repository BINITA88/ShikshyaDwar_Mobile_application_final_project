import 'package:flutter/material.dart';

const String uri = 'http://10.0.2.2:4000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 24, 171, 80),
      Color.fromARGB(255, 24, 171, 83),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(9, 134, 21, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 13, 13, 13);
  static const unselectedNavBarColor = Colors.black87;
}
