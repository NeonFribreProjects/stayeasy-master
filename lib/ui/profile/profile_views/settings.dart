import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colorPallete.dart';
import '../../../reusable_widgets/back_button.dart';
import '../../../reusable_widgets/my_text_widget.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          leading: MyBackButton(kwhite),
          title: MyText(
            text: 'Settings',
            color: kwhite,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Device Settings',
                  size: 15.sp,
                  weight: FontWeight.bold,
                ),
                ...List.generate(
                  2,
                  (index) => Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: index == 0 ? 'Language' : "Currency",
                          size: 12.sp,
                          color: Color(0xff979797),
                          weight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            MyText(
                              text: index == 1 ? '\$ Dollar' : 'English',
                              size: 12.sp,
                              color: Color(0xff979797),
                              weight: FontWeight.bold,
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff979797),
                              size: 10,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                MyText(
                  text: 'About',
                  size: 15.sp,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 15),
                MyText(
                  text: 'Privacy Policy',
                  size: 12.sp,
                  color: Color(0xff979797),
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 15),
                MyText(
                  text: 'Terms And Conditions',
                  size: 12.sp,
                  color: Color(0xff979797),
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
