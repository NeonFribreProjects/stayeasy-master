import 'dart:ui';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/lists/stay_card_list.dart';
import 'package:stay_easy/reusable_widgets/my_custom_container.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/ui/Home/rent_card.dart';
import 'package:stay_easy/ui/Home/stay_card.dart';
// import 'package:stay_easy/ui/hotel_list/hotel_list.dart';
import 'package:stay_easy/utils/token_checker.dart';

// import '../../api/property_api.dart';
import '../../utils/show_toast.dart';
import 'home_controller.dart';

final _controller = Get.put(HomeController());

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedContainer = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    /*24 is for notification bar on Android*/

    var size = MediaQuery.of(context).size;
    double itemHeight = (size.height - kToolbarHeight - 90) / 2.8;
    double itemWidth = size.width / 2;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (_) {},
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  MyContainer(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    color: kprimary,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/sEasy.png',
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                              2,
                              (index) => InkWell(
                                onTap: () {
                                  // _controller.setColor(index);
                                  setState(() {
                                    selectedContainer = index;
                                  });
                                },
                                child: MyContainer(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  color: selectedContainer == index
                                      ? kwhite.withOpacity(0.4)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: selectedContainer == index
                                        ? kwhite
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  margin: EdgeInsets.only(left: 10, top: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        index == 0
                                            ? 'assets/images/bed.png'
                                            : 'assets/images/rent.png',
                                        height: 12,
                                      ),
                                      SizedBox(width: 5),
                                      MyText(
                                        text: index == 0 ? 'Stay' : 'Rent',
                                        size: 15.sp,
                                        color: kwhite,
                                        weight: FontWeight.bold,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  selectedContainer == 0 ? StayCard() : RentCard(),
                  SizedBox(height: 20),
                  MyText(
                    text: 'Book more, Spend Less',
                    size: 15.sp,
                    weight: FontWeight.bold,
                  ),
                  bookMoreSpendLess(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        MyText(
                          text: 'More for you',
                          size: 15.sp,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: 10),
                        moreForYou(itemWidth, itemHeight),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Column homeViewWidgetHeading() {
    return Column(
      children: [
        Image.asset(
          'assets/images/sEasy.png',
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              2,
              (index) => InkWell(
                onTap: () {
                  _controller.setColor(index);
                },
                child: MyContainer(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  color: selectedContainer == index
                      ? kwhite.withOpacity(0.4)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedContainer == index
                        ? kwhite
                        : Colors.transparent,
                    width: 2,
                  ),
                  margin: EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        index == 0
                            ? 'assets/images/bed.png'
                            : 'assets/images/rent.png',
                        height: 12,
                      ),
                      SizedBox(width: 5),
                      MyText(
                        text: index == 0 ? 'Stay' : 'Rent',
                        size: 15.sp,
                        color: kwhite,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  SingleChildScrollView bookMoreSpendLess() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...List.generate(
            stayList.length,
            (index) => Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              padding: EdgeInsets.all(10),
              width: 146.w,
              height: 94.h,
              decoration: BoxDecoration(
                color: kwhite,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: kblack.withOpacity(0.17),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: stayList[index].boldText,
                    size: 12.sp,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  MyText(
                    text: stayList[index].normalText,
                    size: 8.sp,
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GridView moreForYou(double itemWidth, double itemHeight) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: (itemWidth / itemHeight),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        ...List.generate(
          more4youList.length,
          (index) => GestureDetector(
            onTap: () {
              // Get.to(
              //   () => HotelListView(
              //     title: more4youList[index].boldText,
              //   ),
              //   transition: Transition.rightToLeft,
              //   duration: Duration(milliseconds: 300),
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    more4youList[index].img,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0,
                        sigmaY: 0.0,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: kwhite.withOpacity(0.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: more4youList[index].boldText,
                              size: 15.sp,
                              weight: FontWeight.bold,
                            ),
                            MyText(
                              text: more4youList[index].normalText,
                              size: 8.sp,
                              weight: FontWeight.normal,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  getUserDetails() async {
    String token;

    var accessTokenCheck = await TokenChecker().isAccessTokenExpired();

    if (accessTokenCheck[0]) {
      showToast("Unexpected Error", "error");
      return;
    }
    if (accessTokenCheck.length > 1 && accessTokenCheck[0] != null) {
      token = accessTokenCheck[1];
    } else {
      token = await TokenChecker().getToken();
    }

    var url = "https://api.stay2easy.com/user/";

    var headers = {'Authorization': token, 'Accept': '*/*'};

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        SharedPreferences sharedStorage = await SharedPreferences.getInstance();
        await sharedStorage.remove("_user-info");
        User user = User.fromJson(
          jsonDecode(response.body),
        );
        await sharedStorage.setString(
          '_user-info',
          jsonEncode(user),
        );
        print(jsonEncode(user));
        // print(response.body);
        return;
      } else {
        // print(response.statusCode);
        return [jsonDecode(response.body), response.statusCode];
      }
    } catch (e) {
      return throw Exception(e);
    }
  }
}

class User {
  var email;
  var password;
  var firstName;
  var lastName;
  var mobileNumber;
  var dob;
  var gender;
  var smokingPreference;
  var address;
  var profilePic;

  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.dob,
    required this.gender,
    required this.smokingPreference,
    required this.address,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      smokingPreference: json['smokingPreference'] ?? '',
      address: json['address'] ?? '',
      profilePic: json['profilePic'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNumber,
      'dob': dob,
      'gender': gender,
      'smokingPreference': smokingPreference,
      'address': address,
      'profilePic': profilePic
    };
  }
}
