import 'dart:async';

import 'package:get/get.dart';
import 'package:stay_easy/utils/token_checker.dart';

import '../bottombar/bottom_bar_screen.dart';
import '../sign_or_create/sign_or_create.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();

    if (accessTokenCheck[0]) {
      Future.delayed(Duration(seconds: 2)).then(
        (value) => Get.offAll(() => SignOrCreate(),
            transition: Transition.downToUp,
            duration: Duration(milliseconds: 700)),
      );
    } else {
      Future.delayed(Duration(seconds: 2)).then(
        (value) => Get.offAll(() => BottomBarScreen(),
            transition: Transition.downToUp,
            duration: Duration(milliseconds: 700)),
      );
    }
  }
}
