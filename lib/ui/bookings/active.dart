import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../constants/colorPallete.dart';
import '../../reusable_widgets/my_text_widget.dart';

class ActiveCard extends StatelessWidget {
  const ActiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 20,
            ),
            height: 135,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/quickTrips.png',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            MyText(
                              text: 'StayEasy',
                              size: 23.sp,
                              weight: FontWeight.bold,
                            ),
                            MyText(
                              text: 'Los Angeles',
                              size: 12.sp,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: MyText(
                            text: 'Mon 9 Jan - Fri 13 Jan',
                            size: 12.sp,
                            weight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1, top: 8),
                  child: Icon(
                    Icons.location_pin,
                    size: 40,
                    color: Color(0xffDD9F0D),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: Lottie.asset('assets/images/map.json', height: 160),
          ),
          MyText(
            text: 'Where To Next?',
            size: 20.sp,
            weight: FontWeight.bold,
          ),
          MyText(
            align: TextAlign.center,
            text: 'Get Started! All Your Present Booking Will Appear Here.',
            size: 15.sp,
            weight: FontWeight.normal,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
