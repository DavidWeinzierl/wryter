import 'package:flutter/material.dart';

class Constants {
  static double animationOffset = 53;
  static Color? bgColor = const Color.fromARGB(255, 13, 13, 13);

  // static Color promtTextColor = const Color.fromARGB(255, 165, 169, 190);
  // static Color? promtTextColor = Colors.cyan[500];
  // static Color? promtTextColor = const Color.fromARGB(255, 219, 250, 255);
  static Color promtTextColor = const Color.fromARGB(255, 17, 40, 56);
  static Color? wrongColor = const Color.fromARGB(255, 131, 0, 0);
  // static Color? wrongColor = const Color.fromARGB(255, 156, 9, 9);
  // static Color correctColor = const Color.fromARGB(255, 17, 40, 56);
  static Color correctColor = const Color.fromARGB(255, 240, 3, 50);
  static Color? cursorColor = const Color.fromARGB(255, 76, 0, 87);

  static LinearGradient myLinearGradient = const LinearGradient(
    colors: [Colors.cyan, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.3, 0.95],
  );
  static LinearGradient myLinearGradientDark = LinearGradient(
    colors: [Colors.cyan[700]!, Colors.purple[700]!],
    // colors: [Colors.black, Colors.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.3, 0.95],
  );

  // static SweepGradient mySweepGradient = const SweepGradient(
  //   colors: [Colors.purple, Colors.cyan],
  //   center: Alignment.centerRight,
  //   startAngle: 1.5,
  //   endAngle: 4.5,
  // );
}
