import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/lists/profile_model_list.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/ui/Home/home_view.dart';
import 'package:stay_easy/ui/profile/profile_views/manage_your_account.dart';
import 'package:stay_easy/ui/profile/profile_views/our_hotels.dart';
import 'package:stay_easy/ui/profile/profile_views/rewards_and_wallet.dart';
import 'package:stay_easy/utils/token_checker.dart';

import '../../utils/base64_image.dart';
import '../../utils/show_toast.dart';
import '../sign_or_create/sign_or_create.dart';
import 'profile_views/contact_customer_service.dart';
import 'profile_views/reviews.dart';
import 'profile_views/settings.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _show = false;
  Timer? _timer;
  removeToken() {
    TokenChecker().removeToken();
    Get.offAll(() => SignOrCreate());
  }

  var newEmail;
  String profileImage = "";

  void getUserInfo() async {
    String token;
    var url = "https://api.stay2easy.com/user/";

    SharedPreferences sharedStorage = await SharedPreferences.getInstance();

    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();

    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    bool accessTokenLengthAndNullableCheck =
        accessTokenCheck.length > 1 && accessTokenCheck[0] != null;
    if (accessTokenLengthAndNullableCheck) {
      token = accessTokenCheck[1];
    } else {
      token = await TokenChecker().getToken();
    }

    String? userJson = await sharedStorage.getString('_user-info');
    var headers = {'Authorization': token, 'Accept': '*/*'};

    if (userJson != null) {
      User user = User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      setState(() {
        newEmail = user.email;
        profileImage = user.profilePic;
      });
      return;
    } else {
      try {
        var response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          SharedPreferences sharedStorage =
              await SharedPreferences.getInstance();
          User user = User.fromJson(jsonDecode(response.body));
          await sharedStorage.setString('_user-info', jsonEncode(user));
          setState(() {
            newEmail = user.email;
            profileImage = user.profilePic;
          });
        } else {
          return;
        }
      } catch (e) {
        throw Exception(e);
      }
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _showWidget);
  }

  void _showWidget() {
    setState(() {
      _show = true;
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo();

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            height: 192.h,
            width: double.infinity,
            color: kprimary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileImage != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(70),
                        child: Base64Image(
                          base64String: profileImage,
                          width: 70.w,
                          height: 70.h,
                        ),
                      )
                    : Image.asset(
                        'assets/images/profile.png',
                        height: 87.h,
                        width: 87.w,
                      ),
                SizedBox(height: 10),
                MyText(
                  text: newEmail ?? '-------',
                  size: 18.sp,
                  weight: FontWeight.bold,
                  color: kwhite,
                ),
              ],
            ),
          ),
          ...List.generate(
            profileList.length,
            (index) => GestureDetector(
              onTap: () {
                index == 0
                    ? Get.to(() => ManageYourAccount())
                    : index == 1
                        ? Get.to(() => RewardAndWallet())
                        : index == 2
                            ? Get.to(() => OurHotel())
                            : index == 3
                                ? Get.to(() => Reviews())
                                : index == 4
                                    ? Get.to(() => ContactCustomerService())
                                    : index == 5
                                        ? Get.to(() => Settings())
                                        : index == 6
                                            ? removeToken()
                                            : null;
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15.h,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Image.asset(
                        profileList[index].icon,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    MyText(
                      text: profileList[index].text,
                      size: 15.sp,
                      weight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 20),
          Spacer(),
          Container(
            height: 40.h,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50.w),
            width: double.infinity,
            color: kblack,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: 'FAQ',
                  size: 10,
                  color: kwhite,
                  weight: FontWeight.normal,
                ),
                Align(
                  child: MyText(
                    text: 'StayEasy',
                    size: 17,
                    color: kwhite,
                    weight: FontWeight.bold,
                  ),
                ),
                MyText(
                  text: 'About us',
                  size: 10,
                  color: kwhite,
                  weight: FontWeight.normal,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
