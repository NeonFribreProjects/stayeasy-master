import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:get/get.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';

import '../../api/property_api.dart';
import '../../utils/token_checker.dart';
import '../hotel_page/hotel_page.dart';

class SavedView extends StatefulWidget {
  const SavedView({super.key});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  var loading = true;
  var data;

  getBookmarkInfo() async {
    String token = await TokenChecker().getToken();
    var res = await PropertyApi().getAllBookMarks(token);
    var resBody = res[0];

    setState(() {
      loading = false;
      data = resBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    getBookmarkInfo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimary,
        centerTitle: true,
        title: MyText(
          text: 'Saved',
          color: kwhite,
          size: 15.sp,
          weight: FontWeight.bold,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          if (loading) loadingSkeleton(),
          if (!loading)
            data.length > 0
                ? Center(
                    child:
                        Text("Data Exist but not displayed.Working on it...."),
                  )
                // ? savedListCards()
                : Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/No data-pana.svg',
                        width: 200,
                        height: 350,
                      ),
                      Center(
                        child: Text("No Property Saved"),
                      ),
                    ],
                  )
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       ...List.generate(
      //         2,
      //         (index) => Container(
      //           margin: EdgeInsets.only(
      //             left: 15,
      //             right: 15,
      //             top: 20,
      //           ),
      //           height: 135,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //             boxShadow: [
      //               BoxShadow(
      //                 color: kblack.withOpacity(0.16),
      //                 offset: Offset(0, 2),
      //                 blurRadius: 10,
      //               ),
      //             ],
      //             color: kwhite,
      //             border: Border.all(
      //               color: Color(0xff324AB2).withOpacity(0.3),
      //             ),
      //             borderRadius: BorderRadius.circular(5),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Row(
      //                 children: [
      //                   Image.asset(
      //                     'assets/images/quickTrips.png',
      //                     fit: BoxFit.cover,
      //                   ),
      //                   SizedBox(width: 10),
      //                   Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       SizedBox(height: 5),
      //                       MyText(
      //                         text: 'StayEasy',
      //                         size: 23.sp,
      //                         weight: FontWeight.bold,
      //                       ),
      //                       MyText(
      //                         text: 'Los Angeles',
      //                         size: 12.sp,
      //                         weight: FontWeight.bold,
      //                       )
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Icon(
      //                   Icons.favorite,
      //                   size: 40,
      //                   color: Color(0xffDD9F0D),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: EdgeInsets.symmetric(
      //           vertical: 50.h,
      //           horizontal: 180,
      //         ),
      //         child: Divider(
      //           thickness: 4,
      //           color: kblack,
      //         ),
      //       ),
      //       MyText(
      //         text: 'Keep What You Like At Hand',
      //         size: 20.sp,
      //         weight: FontWeight.bold,
      //       ),
      //       MyText(
      //         text: 'Save Your Loved Hotels And Rooms Here.',
      //         size: 15.sp,
      //         weight: FontWeight.normal,
      //       ),
      //       SizedBox(height: 20)
      //     ],
      //   ),
      // ),
    );
  }

  Column savedListCards() {
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
                height: Get.height * 0.21,
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
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Hero(
                          tag: data[index]['id'],
                          transitionOnUserGestures: true,
                          child: Image.network(
                            data[index]['pictures'][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: MyText(
                              text: data[index]['name'],
                              size: 17.sp,
                              weight: FontWeight.bold,
                              wrappable: true,
                              maxLines: 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.0),
                            child: MyText(
                              text: data[index]['city'],
                              size: 16.sp,
                              weight: FontWeight.bold,
                              wrappable: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3, bottom: 3),
                            child: MyText(
                              text: data[index]['country'],
                              size: 13.sp,
                              weight: FontWeight.bold,
                              wrappable: true,
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
}
