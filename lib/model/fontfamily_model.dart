// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class FontFamily {
  static const String gilroyBlack = "NotoKufiArabic Black";
  static const String gilroyLight = "NotoKufiArabic Light";
  static const String gilroyHeavy = "NotoKufiArabic Heavy";
  static const String gilroyMedium = "NotoKufiArabic Medium";
  static const String gilroyBold = "NotoKufiArabic Bold";
  static const String gilroyExtraBold = "NotoKufiArabic ExtraBold";
  static const String gilroyRegular = "NotoKufiArabic Regular";
}

class gradient {
  static const Gradient btnGradient = LinearGradient(
    colors: [defoultColor, Color.fromARGB(255, 12, 118, 199)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Gradient greenGradient = LinearGradient(
    colors: [Color(0xff5bd80e), Color.fromARGB(255, 100, 199, 64)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  static const Gradient lightGradient = LinearGradient(
    colors: [Color(0xffdaedfd), Color(0xffdaedfd)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
    static const Gradient bgGradient = LinearGradient(
    colors: [Colors.purple,Colors.blueAccent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
  // static const Color defoultColor = Color(0xFF6F3DE9);
  static const Color defoultColor = Color.fromARGB(178, 124, 17, 143);
}
