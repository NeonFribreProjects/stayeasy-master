import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/back_button.dart';
import 'package:stay_easy/ui/payment/payment_controller.dart';
import 'package:stay_easy/ui/payment/payment_one.dart';

import '../../constants/styles.dart';
import '../../reusable_widgets/my_text_widget.dart';

PaymentController _controller = Get.put(PaymentController());

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: MediaQuery.of(context).size.height / 7.2,
          color: kprimary,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: '\$150',
                      color: kwhite,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xffDD9F0D),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: MyText(
                            text: 'Includes taxes and Charges',
                            color: kwhite,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(
                    () => PaymentOneView(),
                    transition: Transition.rightToLeft,
                    duration: Duration(milliseconds: 300),
                  );
                },
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: kwhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: MyText(
                      text: 'Final Step',
                      weight: FontWeight.bold,
                      size: 15.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          centerTitle: true,
          leading: MyBackButton(kwhite),
          title: Image.asset(
            'assets/images/payment.png',
            height: 30,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                margin: EdgeInsets.only(
                  bottom: 10,
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
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/quickTrips.png',
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 5.h,
                              left: 80.w,
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
                            Obx(
                              () => SmoothStarRating(
                                allowHalfRating: false,
                                onRatingChanged: (v) {
                                  _controller.setRating(v);
                                },
                                starCount: 5,
                                rating: _controller.rating.value,
                                size: 20.0,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.blur_on,
                                color: Color(0xffDD9F0D),
                                borderColor: Color(0xffDD9F0D),
                                spacing: 0.0,
                              ),
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                MyText(
                                  text:
                                      'California Los Angeles\nUnited State of America',
                                  size: 11.sp,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(height: 10)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Check-in',
                            size: 12.sp,
                            weight: FontWeight.bold,
                          ),
                          MyText(
                            text: 'Sun, 24 Jan 2023',
                            size: 10.sp,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Check-out',
                            size: 12.sp,
                            weight: FontWeight.bold,
                          ),
                          MyText(
                            text: 'Mon, 30 Jan 2023',
                            size: 10.sp,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Guests',
                            size: 12.sp,
                            weight: FontWeight.bold,
                          ),
                          MyText(
                            text: '2 adults',
                            size: 10.sp,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: 'Total',
                            size: 12.sp,
                            weight: FontWeight.bold,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyText(
                                text: '\$150',
                                size: 15.sp,
                                weight: FontWeight.bold,
                              ),
                              MyText(
                                text: 'Includes taxes and Charges',
                                size: 8.sp,
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      color: kblack.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Price Information',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Icon awesome-money-bill-alt.png',
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Includes \$20 in taxes and Charges',
                          size: 8.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MyText(
                      text: 'Booking Condition',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Icon material-do-not-disturb-alt.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Includes \$20 in taxes and Charges',
                          size: 8.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      color: kblack.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Standard Room',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/Icon material-do-not-disturb-alt.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyText(
                                text: 'Non-refundable',
                                size: 8.sp,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(height: 5.h),
                              MyText(
                                text:
                                    'If you cancel, modify the booking, or don\'t show up the fee will be the total price of thereservation.',
                                size: 8.sp,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/person.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: 'Booking for YOUR NAME',
                          size: 8.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Icon ionic-md-people.png',
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(width: 10),
                        MyText(
                          text: '2 Adults & 1 Child',
                          size: 8.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: kwhite,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      color: kblack.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'Do you have any special request',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 10,
                            color: kblack.withOpacity(0.16),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        style: newHintStyle,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Make a Special request',
                          hintStyle: newHintStyle,
                          fillColor: kwhite,
                          filled: true,
                          border: ktransparentside,
                          enabledBorder: ktransparentside,
                          focusedBorder: ktransparentside,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
