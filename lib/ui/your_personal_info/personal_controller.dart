import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController usa = TextEditingController();

  String selectedValue = '';

  RxString selectValue = ''.obs;

  setRadioButton(value) {
    selectValue.value = value;
  }

  void setRadio(value) {
    selectedValue = value;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    lastName.dispose();
    email.dispose();
    mobileNumber.dispose();
    usa.dispose();
  }
}
