import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import '../../constants/styles.dart';
import '../hotel_page/hotel_page.dart';
import 'rent_conrtoller.dart';

RentListController _controller = Get.put(RentListController());

class RentListView extends StatefulWidget {
  const RentListView({super.key});

  @override
  State<RentListView> createState() => _RentListViewState();
}

class _RentListViewState extends State<RentListView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> three = [
    'Popular nearby first',
    'Popularity',
    'Distance from place of interest',
    'Star rating (highest first)',
    'Star rating (lowest first)',
    'Best reviewed first',
    'Most reviewed first',
    'Price (lowest first)',
  ];

  String _threeValue = "Popular nearby first";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: double.infinity,
              color: kprimary,
              child: Column(
                children: [
                  SizedBox(
                    height: 37.h,
                    width: 304.w,
                    child: TextFormField(
                      readOnly: true,
                      style: khintStyleprefix,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: EdgeInsets.fromLTRB(
                          10,
                          5,
                          10,
                          5,
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: kblack.withOpacity(0.7),
                          ),
                        ),
                        hintText: 'Freehand, Los Ang... ',
                        suffixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(
                            10,
                            10,
                            10,
                            5,
                          ),
                          child: MyText(
                            text: '24 Jan - 30 Jan',
                            size: 14.sp,
                            color: kgrey,
                            weight: FontWeight.bold,
                          ),
                        ),
                        hintStyle: khintStyleprefix,
                        fillColor: kwhite,
                        filled: true,
                        border: kborder,
                        enabledBorder: kborder,
                        focusedBorder: kborder,
                        disabledBorder: kborder,
                      ),
                    ),
                  ),
                  Container(
                    width: 304.w,
                    padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          3,
                          (index) => InkWell(
                            onTap: () {
                              index == 0
                                  ? scaffoldKey.currentState!.showBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      (context) => StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return SingleChildScrollView(
                                              child: Container(
                                                width: Get.width,
                                                height: 380.h,
                                                decoration: BoxDecoration(
                                                    color: kprimary
                                                        .withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    30),
                                                            topRight: Radius
                                                                .circular(30))),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .topRight,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color:
                                                                      kprimary,
                                                                )),
                                                          )),
                                                      MyText(
                                                        text: "Sort by",
                                                        size: 22.sp,
                                                        color: kprimary,
                                                        weight: FontWeight.w600,
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        controller:
                                                            ScrollController(),
                                                        itemCount: three.length,
                                                        itemBuilder:
                                                            (context, index) =>
                                                                Container(
                                                          height: 40,
                                                          color: Colors
                                                              .transparent,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              MyText(
                                                                text: three[
                                                                    index],
                                                                color: kprimary,
                                                                weight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              Radio(
                                                                value: three[
                                                                    index],
                                                                groupValue:
                                                                    _threeValue
                                                                        .toString(),
                                                                onChanged:
                                                                    (String?
                                                                        value) {
                                                                  setState(() {
                                                                    _threeValue =
                                                                        value
                                                                            .toString();
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }))
                                  : null;
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  index == 0
                                      ? 'assets/images/sort.png'
                                      : index == 1
                                          ? 'assets/images/filter.png'
                                          : 'assets/images/map.png',
                                  height: 10,
                                  width: 10,
                                ),
                                SizedBox(width: 5.w),
                                MyText(
                                  text: index == 0
                                      ? 'Sort'
                                      : index == 1
                                          ? 'Filter'
                                          : 'Map',
                                  size: 14.sp,
                                  weight: FontWeight.bold,
                                  color: kwhite,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 15.h),
            MyText(
              text: '    Rent a Place',
              size: 15.sp,
              weight: FontWeight.bold,
            ),
            MyText(
              text: '    Frequently booked Locations',
              size: 15.sp,
              weight: FontWeight.normal,
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => HotelPageView(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 300),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 10,
                      ),
                      height: Get.height * 0.235,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: kblack.withOpacity(0.16),
                            offset: Offset(0, 2),
                            blurRadius: 10,
                          ),
                        ],
                        color: kwhite,
                        border: Border.all(
                          color: Color(0xff324AB2).withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    index == 0
                                        ? 'assets/images/quickTrips.png'
                                        : index == 1
                                            ? 'assets/images/takeATour.png'
                                            : index == 2
                                                ? 'assets/images/bookARoom.png'
                                                : 'assets/images/quickTrips.png',
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 6.h,
                                    left: 110.w,
                                    child: Image.asset(
                                      'assets/images/heart.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5),
                                  MyText(
                                    text: 'Freehand Hotel',
                                    size: 17.sp,
                                    weight: FontWeight.bold,
                                  ),
                                  MyText(
                                    text: 'California',
                                    size: 17.sp,
                                    weight: FontWeight.bold,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    child: MyText(
                                      text: 'Los Angeles 32.4ml away',
                                      size: 9.sp,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                  MyText(
                                    text: '4.5/5 Wonderful\n[234 Reviews]',
                                    size: 9.sp,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                bottom: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyText(
                                    text: '\$300',
                                    size: 15.sp,
                                    weight: FontWeight.bold,
                                  ),
                                  MyText(
                                    align: TextAlign.end,
                                    text: 'Includes taxes & fees',
                                    size: 9.sp,
                                    weight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
