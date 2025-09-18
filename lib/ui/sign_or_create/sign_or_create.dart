import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stay_easy/ui/sign_up/sign_up.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/reusable_widgets/elevated_button_widget.dart';

import '../../reusable_widgets/appbar.dart';
import '../login/login_view.dart';

class SignOrCreate extends StatelessWidget {
  const SignOrCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5),
              //   child: MyText(
              //     text: 'Sign In Options',
              //     size: 20.sp,
              //     weight: FontWeight.bold,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 5),
              //   child: MyText(
              //     text: 'Find, book, and enjoy with ease.',
              //     size: 15.sp,
              //     weight: FontWeight.w600,
              //   ),
              // ),

              SvgPicture.asset(
                'assets/images/Traveling-pana.svg',
                width: 200,
                height: 350,
              ),

              Center(
                child: MyText(
                  text: 'Explore and book your dream destinations ',
                  size: 15.sp,
                  weight: FontWeight.w600,
                  align: TextAlign.center,
                  wrappable: true,
                ),
              ),
              Center(
                child: MyText(
                  text: 'with personalized travel experiences.',
                  size: 15.sp,
                  weight: FontWeight.w600,
                  align: TextAlign.center,
                  wrappable: true,
                ),
              ),
              Spacer(),

              MyButton(
                bgcolor: kprimary,
                text: 'Register',
                size: 15.0,
                textColor: kwhite,
                onPress: () {
                  Get.to(
                    () => SignUpView(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 300),
                  );
                },
              ),
              SizedBox(height: 2.h),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: MyText(
                    text: 'OR',
                    size: 14.sp,
                    weight: FontWeight.normal,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              MyButton(
                textColor: kprimary,
                text: 'Login',
                bdcolor: kprimary,
                size: 15.0,
                onPress: () => Get.to(
                  () => LoginView(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 300),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
