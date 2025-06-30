import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:stay_easy/constants/colorPallete.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_easy/ui/splash/splash.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Segeou',
            primarySwatch: Palette.kToDark,
            radioTheme: RadioThemeData(
              fillColor: MaterialStateColor.resolveWith(
                (states) => kprimary,
              ),
            ),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}

/* 
  flutter emulators --launch Pixel_3a_API_31
*/

/* 
  Idea for getting new access token.. before calling the function. check the epoch time with the current time before making the request. if it is above reset the access token before calling the function
 */