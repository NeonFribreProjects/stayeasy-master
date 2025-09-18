import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/appbar.dart';
import 'package:stay_easy/reusable_widgets/my_text_form_field.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/ui/bottombar/bottom_bar_screen.dart';
import 'package:stay_easy/ui/login/login-controller.dart';
import 'package:stay_easy/utils/is_email.dart';

import '../../api/registration_api.dart';
import '../../reusable_widgets/elevated_button_widget.dart';
import '../../utils/show_toast.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/token_checker.dart';

final _controller = Get.put(LoginController());

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var password;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

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
              MyText(
                text: 'Login',
                size: 20.sp,
                weight: FontWeight.bold,
              ),
              MyText(
                text: 'Your gateway to booking and renting experiences.',
                size: 15.sp,
                weight: FontWeight.bold,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    MyFormField(
                      padding: EdgeInsets.only(left: 10),
                      controller: _controller.emailController,
                      hintText: 'Email Address',
                      hintColor: kgrey,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct email";
                        }
                        if (!isEmail(value)) {
                          return "Incorrect email format";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5.h),
                    MyFormField(
                      padding: EdgeInsets.only(left: 10),
                      controller: _controller.passController,
                      hintText: 'Password',
                      hintColor: kgrey,
                      obscureText: true,
                      minLength: 1,
                      maxLength: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter a valid password";
                        }
                        if (value.length < 5) {
                          return 'Your password must be at least 5 charaters.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    MyButton(
                      bgcolor: kprimary,
                      text: 'Login',
                      size: 15.0,
                      textColor: kwhite,
                      loading: loading,
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          _login();
                          return;
                        }
                      },
                    ),
                    // SizedBox(height: 18.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(5),
                    //         ),
                    //         elevation: 0,
                    //         backgroundColor: googleBrand,
                    //         padding:
                    //             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    //       ),
                    //       onPressed: () {
                    //         // _handleGoogleSignIn();
                    //       },
                    //       child: Center(
                    //         child: Text(
                    //           "Login with Google",
                    //           style: TextStyle(fontSize: 17.0),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: ['email'],
  // );

  // Future<void> _handleGoogleSignIn() async {
  //   await _googleSignIn.signOut();
  //   try {
  //     var googleUser = await _googleSignIn.signIn();
  //     print(googleUser);
  //     if (googleUser != null) {
  //       print(googleUser);
  //     }
  //     // Handle successful sign-in here
  //   } on PlatformException catch (error) {
  //     print(error);
  //     if (error.code == 'sign_in_canceled') {
  //       print('Error occurred while signing in: $error');
  //     } else {
  //       print('Error occurred while signing in: $error');
  //     }
  //   }
  // }

  _login() async {
    var data = {
      "email": _controller.emailController.text,
      "password": _controller.passController.text
    };
    setState(() {
      loading = true;
    });
    var res = await RegistrationApi().logIn(json.encode(data), "/login");
    var responseBody = res[0];
    var responseStatusCode = res[1];

    if (responseStatusCode == 200) {
      setState(() {
        loading = false;
      });
      showToast("Successful!.", "success");
      Get.offAll(
        () => BottomBarScreen(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 1000),
      );
      TokenChecker().setToken(responseBody['token']);

      print(responseBody['token']);
      return;
    } else {
      setState(() {
        loading = false;
      });
      showToast("Error! ${responseBody['message']}", "error");
      return;
    }
  }
}
