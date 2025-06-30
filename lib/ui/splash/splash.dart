import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stay_easy/ui/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5B13AE),
        body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (_) {
            return Center(
              child: Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
            );
          },
        ),
      ),
    );
  }
}
