// import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:stay_easy/reusable_widgets/my_custom_container.dart';
import 'package:stay_easy/reusable_widgets/my_text_form_field.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
// import 'package:stay_easy/ui/hotel_list/hotel_list.dart';
import 'package:google_place/google_place.dart';

import '../../constants/colorPallete.dart';
// import '../../lists/stay_card_list.dart';
import '../../reusable_widgets/elevated_button_widget.dart';
import '../search_list/search_list.dart';
import 'home_controller.dart';

// ignore: must_be_immutable
class StayCard extends StatefulWidget {
  StayCard({super.key});

  @override
  State<StayCard> createState() => _StayCardState();
}

class _StayCardState extends State<StayCard> {
  final _controller = Get.put(HomeController());

  var startDateValue;
  var endDateValue;
  final formKey = GlobalKey<FormState>();
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  // Timer? _debounce;
  var userDestination;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String apiKey = 'AIzaSyCibbLQJBOc';
    googlePlace = GooglePlace(apiKey);
  }

  startDateRange(date) {
    setState(() {
      startDateValue = date;
    });
  }

  endDateRange(date) {
    setState(() {
      endDateValue = date;
    });
  }

  void getValues() {
    print(endDateValue);
    print(startDateValue);
    print(_controller.rooms);
    print(_controller.childrens);
    print(_controller.adults);
    print(_controller.stayDestinationController.text);
    Get.to(
      () => SearchListView(
        destination: _controller.stayDestinationController.text,
        startDate: startDateValue,
        endDate: endDateValue,
        rooms: _controller.rooms,
        children: _controller.childrens,
        adults: _controller.adults,
        propertyType: "shortStay",
      ),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 300),
    );
    Future.delayed(Duration(seconds: 2))
        .then((value) => _controller.stayDestinationController.clear());
    Future.delayed(Duration(seconds: 2)).then((value) => _controller.rooms = 0);
    Future.delayed(Duration(seconds: 2))
        .then((value) => _controller.childrens = 0);
    Future.delayed(Duration(seconds: 2))
        .then((value) => _controller.adults = 0);
    Future.delayed(Duration(seconds: 2)).then((value) => setState(() {
          endDateValue = null;
          startDateValue = null;
        }));
    Future.delayed(Duration(seconds: 2))
        .then((value) => _controller.dateRange = null);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyFormField(
              controller: _controller.stayDestinationController,
              hintText: 'Enter your destination',
              hintColor: kgrey,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/search.png',
                  height: 5,
                  width: 5,
                  color: kgrey,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter correct destination";
                }
                return null;
              },
              // onChanged: (value) {
              //   if (_debounce?.isActive ?? false) _debounce!.cancel();
              //   _debounce = Timer(const Duration(milliseconds: 1000), () {
              //     if (value.isNotEmpty) {
              //       // print(value);
              //       setState(() {
              //         userDestination = value;
              //       });
              //     } else {
              //       //clear out the results
              //     }
              //   });
              // },
            ),
            SizedBox(height: 10),
            MyFormField(
              readonly: true,
              ontap: () async {
                _controller.pickDateRange(
                    context, startDateRange, endDateRange);
              },
              controller: _controller.dateController,
              hintColor: _controller.dateRange?.start != null ? kblack : kgrey,
              hintText: _controller.dateRange?.start != null
                  ? DateFormat('E d MMM').format(_controller.dateRange!.start) +
                      " - " +
                      DateFormat('E d MMM').format(_controller.dateRange!.end)
                  : 'Mon 9 Jan - Fri 13 Jan',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/date.png',
                  height: 5,
                  width: 5,
                  color: kgrey,
                ),
              ),
              validator: (value) {
                if (startDateValue == null) {
                  return "Enter a valid date";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            MyFormField(
              readonly: true,
              ontap: () async {
                selectRoomBottomSheet(context);
              },
              controller: _controller.personController,
              hintText: _controller.rooms.toString() +
                  " " +
                  "Room" +
                  " " +
                  _controller.adults.toString() +
                  " " +
                  "Adults" +
                  " " +
                  _controller.childrens.toString() +
                  " " +
                  "Child",
              hintColor: _controller.adults > 0 ||
                      _controller.childrens > 0 ||
                      _controller.rooms > 0
                  ? kblack
                  : kgrey,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  'assets/images/person.png',
                  height: 5,
                  width: 5,
                  color: kgrey,
                ),
              ),
              validator: (value) {
                if (_controller.rooms == 0) {
                  return "Kindly provide number of room needed";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            MyButton(
              bgcolor: kprimary,
              text: 'Search',
              textColor: kwhite,
              onPress: () {
                // Get.to(
                //   () => SearchListView(),
                //   transition: Transition.rightToLeft,
                //   duration: Duration(milliseconds: 300),
                // );
                formKey.currentState?.save();
                if (formKey.currentState!.validate()) {
                  getValues();
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future selectRoomBottomSheet(context) async {
    await showBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return GetBuilder<HomeController>(
              builder: (logic) => Container(
                width: Get.width,
                height: Get.height * 0.46,
                decoration: BoxDecoration(
                  color: kprimary.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            color: kprimary,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      MyText(
                        text: "Select rooms and guests",
                        size: 18.sp,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: "Rooms",
                            size: 18.sp,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _controller.decrementRooms();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kprimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: kwhite,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              MyText(
                                text: _controller.rooms != 0
                                    ? _controller.rooms.toString()
                                    : "0",
                                size: 16.sp,
                              ),
                              SizedBox(width: 10.w),
                              InkWell(
                                onTap: () {
                                  _controller.incrementRooms();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kprimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: kwhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: "Adults",
                            size: 18.sp,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _controller.decrementAdults();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kprimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: kwhite,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              MyText(
                                text: _controller.adults != 0
                                    ? _controller.adults.toString()
                                    : "0",
                                size: 16.sp,
                              ),
                              SizedBox(width: 10.w),
                              InkWell(
                                onTap: () {
                                  _controller.incrementAdults();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kprimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: kwhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: "Children",
                                size: 18.sp,
                              ),
                              MyText(
                                text: "0 - 17 years old",
                                size: 12.sp,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _controller.decrementChildrens();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kprimary,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: kwhite,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              MyText(
                                text: _controller.childrens != 0
                                    ? _controller.childrens.toString()
                                    : "0",
                                size: 16.sp,
                              ),
                              SizedBox(width: 10.w),
                              InkWell(
                                onTap: () {
                                  _controller.incrementChildrens();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: kprimary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.add,
                                    color: kwhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      MyButton(
                        bgcolor: kprimary,
                        text: "Apply",
                        textColor: kwhite,
                        onPress: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
