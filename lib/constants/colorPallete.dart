import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff5B13AE, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff5b13ae), //10%
      100: const Color(0xff52119d), //20%
      200: const Color(0xff490f8b), //30%
      300: const Color(0xff400d7a), //40%
      400: const Color(0xff370b68), //50%
      500: const Color(0xff2e0a57), //60%
      600: const Color(0xff240846), //70%
      700: const Color(0xff1b0634), //80%
      800: const Color(0xff120423), //90%
      900: const Color(0xff090211), //100%
    },
  );
} // you can define define int

const Color kprimary = Color(0xff5B13AE);
const Color kwhite = Colors.white;
const Color kblack = Colors.black;
const Color kgrey = Color(0xffC2C2C2);
const Color kerror = Colors.red;
const Color kgold = Color.fromARGB(255, 248, 203, 1);
const Color googleBrand = Color.fromARGB(255, 222, 83, 70);
