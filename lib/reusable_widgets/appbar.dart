import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'my_text_widget.dart';

// Text TitleWidget({required String text}) {
//   return Text(
//     '$text',
//     style: TextStyle(
//       fontSize: 20.sp,
//       fontWeight: FontWeight.bold,
//       color: kwhite,
//     ),
//   );
// }

AppBar appBarWidget() {
  return AppBar(
    centerTitle: true,
    title: Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Image.asset(
        'assets/images/sEasy.png',
        height: 45,
      ),
    ),
  );
}
