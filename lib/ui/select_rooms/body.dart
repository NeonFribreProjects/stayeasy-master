import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stay_easy/utils/show_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Home/home_view.dart';
import '../../api/booking_api.dart';
import '../../utils/token_checker.dart';
import '../../constants/colorPallete.dart';
import '../your_personal_info/personal_info.dart';
import '../../reusable_widgets/my_text_widget.dart';
import '../../reusable_widgets/elevated_button_widget.dart';

void openURL(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget Body(roomInfo, context, id, pictures, index, propertyType) {
  getUserInfo(roomId) async {
    SharedPreferences sharedStorage = await SharedPreferences.getInstance();
    String? userJson = await sharedStorage.getString('_user-info');

    User user = User.fromJson(jsonDecode(userJson!));

    DateTime now = DateTime.now();
    String iso8601Date = now.toIso8601String();
    String trimmedDate = iso8601Date.substring(0, 10);

    bool anyValueNull(User user) {
      for (var value in [
        user.gender,
        user.firstName,
        user.address,
        user.dob,
        user.mobileNumber,
        user.lastName,
      ]) {
        if (value == null || value.isEmpty) {
          return true;
        }
      }
      return false;
    }

    if (anyValueNull(user)) {
      Get.to(
        () => PersonalInfoView(
          propertyType: propertyType,
          roomId: roomId,
          propertyId: id,
          date: trimmedDate,
        ),
        transition: Transition.rightToLeft,
        duration: Duration(
          milliseconds: 300,
        ),
      );
      showToast(
        "Personal information incomplete",
        "error",
      );
      return;
    }

    String token = await TokenChecker().getToken();

    var bookingInfo = {
      "stayStartDate": trimmedDate,
      "stayEndDate": trimmedDate,
      "propertyId": id,
      "roomId": roomId,
      "propertyType": propertyType
    };
    var bookPropertyResponse = await BookingApi.bookProperty(
      json.encode(bookingInfo),
      token,
    );

    var bookingResponseBody = bookPropertyResponse[0];
    var bookingResponseStatusCode = bookPropertyResponse[1];

    if (bookingResponseStatusCode == 200) {
      // var checkoutUrl = bookingResponseBody['checkoutUrl'];
      // Uri checkoutParsedUri = Uri.parse(checkoutUrl);
      // openURL(checkoutParsedUri);
      showToast(
        "Successfully booked, but an error occured!",
        "success",
      );
      return;
    }
    showToast(
      "Unexpected Error!",
      "error",
    );
    return;
  }

  double screenWidth = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    decoration: BoxDecoration(
      color: kwhite,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          color: kblack.withOpacity(0.16),
          blurRadius: 10,
        ),
      ],
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              pictures[index],
              height: 200,
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            roomInfo.containsKey('roomName')
                ? MyText(
                    text: roomInfo['roomName'],
                    size: 23.sp,
                    weight: FontWeight.bold,
                  )
                : SizedBox(
                    height: 1.0,
                  ),
            MyText(
              text: roomInfo['cancellation'],
              size: 12.sp,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/Icon awesome-person-booth.png',
                        color: kblack,
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(width: 10),
                      MyText(
                        text: "Price for 2 adults . children",
                        // text: 'Price for 2 adults . No children',
                        size: 12.sp,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                roomInfo.containsKey("bedOptions")
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Image.asset(
                            //   'assets/images/bed.png',
                            //   color: kblack,
                            //   height: 13,
                            //   width: 13,
                            // ),
                            Icon(Icons.hotel),
                            SizedBox(width: 10),
                            MyText(
                              text: roomInfo["bedOptions"],
                              // text: '1 Double bed',
                              size: 12.sp,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1.0,
                      ),
                roomInfo.containsKey("extraBedOption")
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.hotel,
                            ),
                            SizedBox(width: 10),
                            MyText(
                              text:
                                  'Extra-Bed Option : ${roomInfo["extraBedOption"] ? "Available" : "Not available"}',
                              size: 12.sp,
                              // color: kprimary,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                roomInfo.containsKey("pets")
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.pets,
                            ),
                            SizedBox(width: 10),
                            MyText(
                              text:
                                  'Pets : ${roomInfo["pets"] ? 'Allowed' : 'Not Allowed'}',
                              size: 12.sp,
                              // color: kprimary,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.room,
                      ),
                      SizedBox(width: 10),
                      MyText(
                        text: '${roomInfo["numberOfRooms"]} rooms',
                        size: 12.sp,
                        // color: kprimary,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                roomInfo.containsKey("children")
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.child_care,
                            ),
                            SizedBox(width: 10),
                            MyText(
                              text:
                                  'Children : ${roomInfo["children"] ? 'Allowed' : 'Not Allowed'}',
                              size: 12.sp,
                              // color: kprimary,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                roomInfo.containsKey("numberOfGuestsAllowed")
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.people,
                            ),
                            SizedBox(width: 10),
                            MyText(
                              text:
                                  '${roomInfo["numberOfGuestsAllowed"]} Allowed Guests',
                              size: 12.sp,
                              // color: kprimary,
                              weight: FontWeight.bold,
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 1,
                      ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.square_foot,
                      ),
                      SizedBox(width: 10),
                      MyText(
                        text: 'Room Size: 30m',
                        // text: 'Room Size: {$roomSize}m',
                        size: 12.sp,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: 'Amenities',
                          size: 17.sp,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                    roomInfo['amenities'].length,
                                    (index) => Row(
                                      children: [
                                        showAmenities(
                                            roomInfo['amenities'][index])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 15.h),
        MyText(
          text: 'Price for per night',
          size: 12.sp,
          weight: FontWeight.bold,
        ),
        MyText(
          text: '\$${roomInfo['pricePerNight']}',
          size: 15.sp,
          weight: FontWeight.bold,
        ),
        MyText(
          text: 'Includes taxes and Charges',
          size: 12.sp,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 15.h),
        SizedBox(
          height: 45,
          child: MyButton(
            text: 'Select',
            onPress: () {
              getUserInfo(roomInfo['id']);
            },
            bgcolor: Colors.transparent,
            bdcolor: kprimary,
          ),
        ),
      ],
    ),
  );
}

Widget showAmenities(String condition) {
  switch (condition) {
    case 'AirConditioning':
      return Row(
        children: [
          Icon(Icons.ac_unit),
          SizedBox(width: 8),
          MyText(
            text: 'Air Conditioning',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    case 'Bath':
      return Row(
        children: [
          Icon(Icons.bathtub),
          SizedBox(width: 8),
          MyText(
            text: 'Bath',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    case 'SpaBath':
      return Row(
        children: [
          Icon(Icons.spa),
          SizedBox(width: 8),
          MyText(
            text: 'Spa Bath',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    case 'FlatScreenTV':
      return Row(
        children: [
          Icon(Icons.tv),
          SizedBox(width: 8),
          MyText(
            text: 'FlatScreen TV',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    case 'ElectricKettle':
      return Row(
        children: [
          Icon(Icons.electric_rickshaw),
          SizedBox(width: 8),
          MyText(
            text: 'Electric Kettle',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    case 'BalconyView':
      return Row(
        children: [
          Icon(Icons.balcony),
          SizedBox(width: 8),
          MyText(
            text: 'Balcony View',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    case 'Terrece':
      return Row(
        children: [
          Icon(Icons.terrain),
          SizedBox(width: 8),
          MyText(
            text: 'Terrain',
            size: 12.sp,
            weight: FontWeight.bold,
          )
        ],
      );
    default:
      return MyText(
        text: 'Default widget',
        size: 12.sp,
        weight: FontWeight.bold,
      );
  }
}
