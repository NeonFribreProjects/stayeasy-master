import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stay_easy/api/property_api.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/back_button.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';
import 'package:stay_easy/ui/hotel_page/hotel_page.dart';

import '../../utils/token_checker.dart';

// ignore: must_be_immutable
class SearchListView extends StatefulWidget {
  String? destination;
  var startDate;
  var endDate;
  var rooms;
  var children;
  var adults;
  var propertyType;
  var minPrice;
  var maxPrice;
  var bedPreference;

  SearchListView({
    super.key,
    required this.destination,
    this.startDate,
    this.endDate,
    this.rooms,
    this.children,
    this.adults,
    this.propertyType,
    this.maxPrice,
    this.minPrice,
    this.bedPreference,
  });

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  bool loading = true;

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

  var data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String token = await TokenChecker().getToken();

    var res = await PropertyApi().getSearchedProperty(
      destination: widget.destination,
      token: token,
      bedPreference: widget.bedPreference,
      children: widget.children,
      endDate: widget.endDate,
      guests: widget.adults,
      rooms: widget.rooms,
      maxPrice: widget.maxPrice,
      propertyType: widget.propertyType,
      minPrice: widget.minPrice,
      startDate: widget.startDate,
    );

    var responseBody = res[0];
    var responseStatusCode = res[1];

    if (responseStatusCode == 200) {
      setState(() {
        loading = false;
        data = responseBody;
      });
    } else {
      setState(() {
        loading = false;
        data = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchListHeader(),
            SizedBox(height: 15.h),
            if (loading) loadingSkeleton(),
            if (!loading)
              data.length > 0
                  ? searchListCards()
                  : Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/No data-amico.svg',
                          width: 200,
                          height: 350,
                        ),
                        Center(
                          child: Text("Oops,No items matching your search!"),
                        ),
                      ],
                    )
          ],
        ),
      ),
    );
  }

  Column searchListCards() {
    print(data[0]['rooms'][0]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => HotelPageView(
                    data: data[index],
                  ),
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
                width: double.infinity,
                height: Get.height * 0.23,
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
                  children: [
                    Container(
                      width: Get.width * 0.40,
                      height: double.infinity,
                      child: Image.network(
                        data[index]['pictures'][0],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7.0),
                            child: MyText(
                              text: data[index]['name'],
                              size: 17.sp,
                              weight: FontWeight.bold,
                              wrappable: true,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: kgold,
                                size: 20.0,
                              ),
                              SizedBox(width: 3.w),
                              data[index].containsKey('starRating')
                                  ? MyText(
                                      text: '${data[index]['starRating']} / 5',
                                      size: 10.sp,
                                      weight: FontWeight.bold,
                                    )
                                  : MyText(
                                      text: '${data[index]['reviewScore']} / 5',
                                      size: 10.sp,
                                      weight: FontWeight.bold,
                                    ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: MyText(
                                  text:
                                      '${data[index]['city']}, ${data[index]['country']}',
                                  size: 9.sp,
                                  weight: FontWeight.bold,
                                  wrappable: true,
                                  maxLines: 4,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 7.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    data[index]['rooms'][0]
                                            .containsKey('roomName')
                                        ? MyText(
                                            text: data[index]['rooms'][0]
                                                ['roomName'],
                                            size: 10.sp,
                                            weight: FontWeight.bold,
                                          )
                                        : MyText(
                                            text: data[index]['rooms'][0]
                                                ['roomType'],
                                            size: 10.sp,
                                            weight: FontWeight.bold,
                                          ),
                                    data[index]['rooms'][0]
                                            .containsKey('roomSize')
                                        ? Row(
                                            children: [
                                              Text(
                                                "Room Size: ",
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                              MyText(
                                                text: data[index]['rooms'][0]
                                                            ['roomSize']
                                                        .toString() +
                                                    'm',
                                                size: 13.sp,
                                                weight: FontWeight.bold,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                "Lease Period: ",
                                                style: TextStyle(fontSize: 9.0),
                                              ),
                                              MyText(
                                                text: data[index]['rooms'][0]
                                                        ['lease']
                                                    .toString(),
                                                size: 10.sp,
                                                weight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                    MyText(
                                      text:
                                          '\$${data[index]['rooms'][0]['pricePerNight']}',
                                      size: 13.sp,
                                      weight: FontWeight.bold,
                                    ),
                                    MyText(
                                      text: 'Include taxes and charges',
                                      size: 10.sp,
                                      weight: FontWeight.bold,
                                    ),
                                    MyText(
                                      text: data[index]['rooms'][0]
                                          ['cancellation'],
                                      size: 10.sp,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Expanded loadingSkeleton() {
    return Expanded(
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 10,
            ),
            height: Get.height * 0.22,
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
            child: Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 221, 219, 219),
              highlightColor: Color.fromARGB(255, 201, 190, 190),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 200.0,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 10.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 15),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 10.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 8),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 10.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 8),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 5,
                        height: 10.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 8),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 6,
                        height: 10.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 8),
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
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 10.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 8),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            height: 10.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 8),
                          ),
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
    );
  }

  Container searchListHeader() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.infinity,
      color: kprimary,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                // color: kwhite,
                // border: Border.all(
                //   color: Color(0xffDD9F0D),
                //   width: 2,
                // ),
                ),
            height: 37.h,
            width: 304.w,
            child: Row(
              children: [
                MyBackButton(kgrey),
                Expanded(
                  child: Text(
                    widget.destination.toString(),
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 15, top: 15, left: 25, right: 25),
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
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              (context) => StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      width: Get.width,
                                      height: 340.h,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
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
                                            ),
                                            MyText(
                                              text: "Sort by",
                                              size: 22.sp,
                                              color: kprimary,
                                              weight: FontWeight.w600,
                                            ),
                                            SizedBox(height: 10.h),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              controller: ScrollController(),
                                              itemCount: three.length,
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                height: 40,
                                                color: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    MyText(
                                                      text: three[index],
                                                      color: kprimary,
                                                      weight: FontWeight.w600,
                                                    ),
                                                    Radio(
                                                      value: three[index],
                                                      groupValue: _threeValue
                                                          .toString(),
                                                      onChanged:
                                                          (String? value) {
                                                        setState(() {
                                                          _threeValue =
                                                              value.toString();
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
                                },
                              ),
                            )
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
    );
  }
}
