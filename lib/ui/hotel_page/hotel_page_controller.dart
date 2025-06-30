import 'package:get/get.dart';

class HotelPageController extends GetxController {
  RxDouble rating = 0.0.obs;

  setRating(v) {
    rating.value = v;
  }
}
