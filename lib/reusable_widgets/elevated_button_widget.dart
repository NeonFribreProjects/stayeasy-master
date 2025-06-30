import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colorPallete.dart';
import 'my_text_widget.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  var bgcolor;
  var bdcolor;
  final text;
  var textColor;
  var size;
  VoidCallback? onPress;
  bool loading;

  MyButton({
    Key? key,
    required this.text,
    this.loading = false,
    this.bgcolor = Colors.transparent,
    this.bdcolor = Colors.transparent,
    this.textColor = kprimary,
    this.size = 13.0,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h * 0.072,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(width: 1.0, color: bdcolor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          backgroundColor: bgcolor,
        ),
        onPressed: onPress,
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : MyText(
                  align: TextAlign.center,
                  text: '$text',
                  size: size,
                  weight: FontWeight.w600,
                  color: textColor,
                ),
        ),
      ),
    );
  }
}
