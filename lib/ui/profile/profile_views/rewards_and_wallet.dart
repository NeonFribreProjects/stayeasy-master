import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colorPallete.dart';
import '../../../reusable_widgets/back_button.dart';
import '../../../reusable_widgets/my_text_widget.dart';

class RewardAndWallet extends StatelessWidget {
  const RewardAndWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          leading: MyBackButton(kwhite),
          title: MyText(
            text: 'Reward And Wallet',
            color: kwhite,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: 'Your Wallet',
                size: 15.sp,
                weight: FontWeight.bold,
                color: kblack,
              ),
              SizedBox(height: 10),
              MyText(
                text: '\$340',
                size: 23.sp,
                weight: FontWeight.bold,
                color: kblack,
              ),
              SizedBox(height: 20),
              MyText(
                text: 'Add Cash',
                size: 15.sp,
                weight: FontWeight.bold,
                color: kblack,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset(
                        index == 0
                            ? 'assets/images/mster.png'
                            : index == 1
                                ? 'assets/images/Visa.svg.png'
                                : 'assets/images/paypal.png',
                        height: 30,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              MyText(
                text: 'Payment',
                size: 15.sp,
                weight: FontWeight.bold,
                color: kblack,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(right: 25),
                      child: Column(
                        children: [
                          Image.asset(
                            index == 0
                                ? 'assets/images/card.png'
                                : index == 1
                                    ? 'assets/images/pypl.png'
                                    : 'assets/images/applpy.png',
                            height: 30,
                          ),
                          SizedBox(height: 5),
                          MyText(
                            text: index == 0
                                ? 'New Card'
                                : index == 1
                                    ? 'Paypal'
                                    : 'Apple Pay',
                            size: 10.sp,
                            weight: FontWeight.bold,
                            color: kblack,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              MyText(
                text: 'Your Reward',
                size: 15.sp,
                weight: FontWeight.bold,
                color: kblack,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Image.asset(
                    'assets/images/Group 19.png',
                    height: 100,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
