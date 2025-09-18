import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchListController extends GetxController {
  TextEditingController hListController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    hListController.dispose();
  }
}
