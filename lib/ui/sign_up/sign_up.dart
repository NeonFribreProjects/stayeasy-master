import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/appbar.dart';
import 'package:stay_easy/reusable_widgets/my_text_form_field.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/utils/is_email.dart';

import '../../reusable_widgets/elevated_button_widget.dart';
import "../../api/registration_api.dart";
// import '../bottombar/bottom_bar_screen.dart';
import '../../utils/show_toast.dart';
import '../login/login_view.dart';
import 'sign_controller.dart';

final _controller = Get.put(SignUpController());

// ignore: must_be_immutable
class SignUpView extends StatefulWidget {
  SignUpView({
    super.key,
  });

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var password;
  bool loading = false;

  final formKey = GlobalKey<FormState>();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      showToast("Successful!.", "success");
    } catch (error) {
      print('Error occurred while signing in: $error');
      showToast('Error occurred while signing in: $error', "error");
    }
  }

  _register() async {
    var data = {
      "email": _controller.emailController.text,
      "name": "string",
      "languagePreference": "string",
      "password": _controller.passController.text
    };
    setState(() {
      loading = true;
    });
    var res = await RegistrationApi().signUp(json.encode(data), "/");
    var responseBody = res[0];
    var responseStatusCode = res[1];

    if (responseStatusCode == 200) {
      setState(() {
        loading = false;
      });
      showToast("Successful!.", "success");
      Get.to(
        () => LoginView(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 1000),
      );
      // print(responseBody['token']);
      return;
    } else {
      setState(() {
        loading = false;
      });
      showToast("Error! ${responseBody['message']}", "error");
      return;
    }
  }

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
                text: 'Create Your Account',
                size: 20.sp,
                weight: FontWeight.bold,
              ),
              MyText(
                text: 'Join us and start booking your adventures.',
                size: 15.sp,
                weight: FontWeight.bold,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
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
                        password = value;
                      },
                    ),
                    SizedBox(height: 5.h),
                    MyFormField(
                      padding: EdgeInsets.only(left: 10),
                      controller: _controller.confirmpassController,
                      hintText: 'Confirm Password',
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
                        if (value != password) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    MyButton(
                      bgcolor: kprimary,
                      text: 'Sign Up',
                      size: 15.0,
                      loading: loading,
                      textColor: kwhite,
                      onPress: () {
                        formKey.currentState?.save();
                        if (formKey.currentState!.validate()) {
                          _register();
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
                    //           "Sign Up with Google",
                    //           style: TextStyle(fontSize: 17.0),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
