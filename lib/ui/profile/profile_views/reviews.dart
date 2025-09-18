import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colorPallete.dart';
import '../../../reusable_widgets/back_button.dart';
import '../../../reusable_widgets/my_text_widget.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          leading: MyBackButton(kwhite),
          title: MyText(
            text: 'Reviews',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up),
                    SizedBox(width: 10),
                    MyText(
                      text: 'Your Reviews',
                      size: 15.sp,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                ...List.generate(
                  5,
                  (index) => Container(
                    width: Get.width,
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kwhite,
                      boxShadow: [
                        BoxShadow(
                          color: kblack.withOpacity(0.16),
                          offset: Offset(0, 6),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: 'Freehand Hotel',
                          size: 16.sp,
                          weight: FontWeight.bold,
                        ),
                        MyText(
                          text: 'California Los Angeles',
                          size: 16.sp,
                          weight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            ...List.generate(
                              4,
                              (index) => Container(
                                child: Icon(
                                  Icons.star,
                                  color: Color(0xffdd9f08),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        MyText(
                          text:
                              'A nice hotel with good guest rooms and great experience. I recommend',
                          size: 12.sp,
                          weight: FontWeight.bold,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
