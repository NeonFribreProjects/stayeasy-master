import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxDouble rating = 0.0.obs;

  setRating(v) {
    rating.value = v;
  }

  String selectedValue = '';

  void setRadio(value) {
    selectedValue = value;
    update();
  }
}
