import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/back_button.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/ui/select_rooms/select_rooms.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../api/property_api.dart';
import '../../utils/show_toast.dart';
import '../../utils/token_checker.dart';

// ignore: must_be_immutable
class HotelPageView extends StatelessWidget {
  var data;

  HotelPageView({super.key, this.data});
  int firstIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Get.to(
              () => SelectRoomsView(
                data: data,
              ),
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 300),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 15,
            color: kprimary,
            child: Center(
              child: MyText(
                text: 'Select Rooms',
                color: kwhite,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(
                title: data["name"],
                subHeading: data['country'],
                propertyId: data['id'],
                propertyType: data.containsKey('longstayProperty')
                    ? "longStay"
                    : "shortStay",
                bookMarkId: data['bookMarkId'],
              ),
              CarouselSlider(
                items: [
                  ...List.generate(
                    data['pictures'].length,
                    (index) => Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width / 1.3,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          child: Image.network(
                            data['pictures'][index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      color: kblack.withOpacity(0.16),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ...List.generate(
                          2,
                          (index) => Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: index == 1
                                      ? data["checkOutTime"] != null
                                          ? "Check Out : ${data["checkOutTime"]}"
                                          : 'Check Out : Not provided'
                                      : data["checkInTime"] != null
                                          ? "Check In : ${data["checkInTime"]}"
                                          : 'Check In : Not provided',
                                  size: 14.sp,
                                  color: kprimary,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // TODO:add google map
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.zero,
              //   height: MediaQuery.of(context).size.height / 5.6,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: AssetImage('assets/images/los.png'),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      color: kblack.withOpacity(0.16),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: MyText(
                        text:
                            '${data['streetAddress']} ${data['city']}, ${data['country']}',
                        size: 9.sp,
                        weight: FontWeight.bold,
                        wrappable: true,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Description',
                      size: 17.sp,
                      weight: FontWeight.bold,
                    ),
                    MyText(
                      text: data['description'],
                      size: 12.sp,
                      weight: FontWeight.bold,
                      wrappable: true,
                      maxLines: 10,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Facilities',
                      size: 17.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ...List.generate(
                          data['rooms'][0]['availableFacilities'].length,
                          (index) => Row(
                            children: [
                              showAvailableFacilities(data['rooms'][0]
                                  ['availableFacilities'][index])
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showAvailableFacilities(String condition) {
    switch (condition) {
      case 'FreeWiFi':
        return Row(
          children: [
            Icon(Icons.wifi),
            SizedBox(width: 8),
            MyText(
              text: 'Free WiFi',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'Restaurants':
        return Row(
          children: [
            Icon(Icons.restaurant),
            SizedBox(width: 8),
            MyText(
              text: 'Restaurants',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'RoomService':
        return Row(
          children: [
            Icon(Icons.room_service),
            SizedBox(width: 8),
            MyText(
              text: 'Room Service',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'Bar':
        return Row(
          children: [
            Icon(Icons.local_bar),
            SizedBox(width: 8),
            MyText(
              text: 'Bar',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'TwentyFourHourFrontDesk':
        return Row(
          children: [
            Icon(Icons.access_time),
            SizedBox(width: 8),
            MyText(
              text: '24 Hours FrontDesk',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'Sauna':
        return Row(
          children: [
            Icon(Icons.spa),
            SizedBox(width: 8),
            MyText(
              text: 'Sauna',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'FitnessCentre':
        return Row(
          children: [
            Icon(Icons.fitness_center),
            SizedBox(width: 8),
            MyText(
              text: 'Fitness Centre',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'Garden':
        return Row(
          children: [
            Icon(Icons.landscape),
            SizedBox(width: 8),
            MyText(
              text: 'Garden',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'Terrace':
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
      case 'NonSmokingRooms':
        return Row(
          children: [
            Icon(Icons.smoke_free),
            SizedBox(width: 8),
            MyText(
              text: 'Air Conditioning',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'AirportShuttle':
        return Row(
          children: [
            Icon(Icons.directions_car),
            SizedBox(width: 8),
            MyText(
              text: 'Airport Shuttle',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'FamilyRooms':
        return Row(
          children: [
            Icon(Icons.family_restroom),
            SizedBox(width: 8),
            MyText(
              text: 'Family Rooms',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'SpaAndWellnessCentre':
        return Row(
          children: [
            Icon(Icons.spa),
            SizedBox(width: 8),
            MyText(
              text: 'Spa and Wellness Centre',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'HotTubOrJacuzzi':
        return Row(
          children: [
            Icon(Icons.hot_tub),
            SizedBox(width: 8),
            MyText(
              text: 'HotTub or Jacuzzi',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
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
      case 'WaterPark':
        return Row(
          children: [
            Icon(Icons.waterfall_chart_rounded),
            SizedBox(width: 8),
            MyText(
              text: 'Water Park',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      case 'SwimmingPool':
        return Row(
          children: [
            Icon(Icons.pool),
            SizedBox(width: 8),
            MyText(
              text: 'Swimming Pool',
              size: 12.sp,
              weight: FontWeight.bold,
            )
          ],
        );
      default:
        return Text('Default widget');
    }
  }
}

// ignore: must_be_immutable
class AppBarWidget extends StatefulWidget {
  var title;

  var subHeading;

  var propertyId;
  var propertyType;

  var bookMarkId;

  AppBarWidget({
    super.key,
    required this.title,
    required this.subHeading,
    required this.propertyType,
    required this.propertyId,
    this.bookMarkId,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget>
    with TickerProviderStateMixin {
  bool _isFirstWidgetVisible = true;
  var apiBookMarkId = "";

  Future bookMarkPropertyRes() async {
    String token = await TokenChecker().getToken();
    var res = await PropertyApi().bookMarkProperty(
      widget.propertyId,
      widget.propertyType,
      token,
    );

    return res;
  }

  Future _toggleWidgets() async {
    String token = await TokenChecker().getToken();

    if (apiBookMarkId == "") {
      var res = await bookMarkPropertyRes();
      var responseStatusCode = await res[1];
      var responseBody = await res[0];

      if (responseStatusCode == 200) {
        setState(() {
          _isFirstWidgetVisible = !_isFirstWidgetVisible;
          apiBookMarkId = responseBody["bookMarkId"];
        });
        return;
      } else {
        // print(responseStatusCode);
        showToast("$responseBody", "error");
        return;
      }
    }
    var res =
        await PropertyApi().deleteBookMark(json.encode(apiBookMarkId), token);
    var responseStatusCode = await res[1];
    var responseBody = await res[0];

    if (responseStatusCode == 200) {
      setState(() {
        _isFirstWidgetVisible = !_isFirstWidgetVisible;
        apiBookMarkId = widget.bookMarkId;
      });
      return;
    } else {
      showToast("$responseBody", "error");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isFirstWidgetVisible = widget.bookMarkId == null ? true : false;
      apiBookMarkId = widget.bookMarkId == null ? "" : widget.bookMarkId;
    });
    return Container(
      height: Get.height * 0.13,
      padding: EdgeInsets.all(20),
      width: double.infinity,
      color: kprimary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyBackButton(kwhite),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: widget.title,
                    size: 15.sp,
                    weight: FontWeight.bold,
                    color: kwhite,
                  ),
                  MyText(
                    text: widget.subHeading,
                    size: 9.sp,
                    weight: FontWeight.bold,
                    color: kwhite,
                  ),
                ],
              ),
            ],
          ),
          widget.bookMarkId == "N/A"
              ? SizedBox(
                  width: 1,
                )
              : GestureDetector(
                  onTap: _toggleWidgets,
                  child: AnimatedCrossFade(
                    firstChild: Icon(
                      Icons.favorite_outline,
                      color: kwhite,
                      size: 25,
                    ),
                    secondChild: Icon(
                      Icons.favorite,
                      size: 25,
                      color: Color.fromARGB(255, 50, 178, 61),
                    ),
                    crossFadeState: _isFirstWidgetVisible
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(
                      milliseconds: 300,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
/* 

              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Available facilities',
                      size: 17.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 3),
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
                                data['availableFacilities'].length,
                                (index) => Row(
                                  children: [
                                    MyText(
                                      text: data['availableFacilities'][index],
                                      size: 12.sp,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),




 */