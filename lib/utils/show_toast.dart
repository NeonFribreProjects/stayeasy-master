import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/colorPallete.dart';

void showToast(String responseMessage, String state,
    {ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
    msg: responseMessage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: state == 'success' ? kprimary : kerror,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
