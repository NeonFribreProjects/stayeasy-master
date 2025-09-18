// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/colorPallete.dart';

class HomeController extends GetxController {
  int rooms = 0;
  int adults = 0;
  int childrens = 0;
  incrementRooms() {
    if (rooms >= 0) {
      rooms++;
    }
    update();
  }

  decrementRooms() {
    if (rooms > 0) {
      rooms--;
    }
    update();
  }

  incrementAdults() {
    if (adults >= 0) {
      adults++;
    }
    update();
  }

  decrementAdults() {
    if (adults > 0) {
      adults--;
    }
    update();
  }

  incrementChildrens() {
    if (childrens >= 0) {
      childrens++;
    }
    update();
  }

  decrementChildrens() {
    if (childrens > 0) {
      childrens--;
    }
    update();
  }

  TextEditingController stayDestinationController = TextEditingController();
  TextEditingController rentDestinationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController personController = TextEditingController();
  TextEditingController priceControlller = TextEditingController();
  TextEditingController bedControlller = TextEditingController();
  DateTimeRange? dateRange;

  Future pickDateRange(context, startDateRange, endDateRange) async {
    DateTimeRange? newDateTimeRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: kprimary,
              colorScheme: ColorScheme.fromSeed(seedColor: kprimary),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });
    if (newDateTimeRange != null) {
      dateRange = newDateTimeRange;
      update();
      var timeParts = newDateTimeRange.toString().split(' - ');
      // Convert the time parts to DateTime objects
      DateTime startDate = DateTime.parse(timeParts[0]);
      DateTime endDate = DateTime.parse(timeParts[1]);
      String startISOString = DateFormat("yyyy-MM-dd").format(startDate);
      String endISOString = DateFormat("yyyy-MM-dd").format(endDate);
      // Convert DateTime objects to ISO 8601 strings
      // String startISOString = startDate.toIso8601String();
      // String endISOString = endDate.toIso8601String();

      startDateRange("$startISOString");

      endDateRange("$endISOString");
    }
  }

  void dobChanged(DateTime date) {
    dateController.text = date.toString().split(' ')[0];
    update();
  }

  var selectedContainer = 0;
  var view = 0;

  void setColor(index) {
    selectedContainer = index;
    view = index;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    stayDestinationController.dispose();
    rentDestinationController.dispose();
    dateController.dispose();
    personController.dispose();
  }
}
