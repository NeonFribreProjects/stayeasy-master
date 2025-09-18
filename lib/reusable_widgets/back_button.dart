import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget MyBackButton(var color) {
  return GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Icon(
      Icons.arrow_back_ios,
      color: color,
    ),
  );
}
