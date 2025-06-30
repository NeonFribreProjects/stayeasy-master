import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';

import 'home_controller.dart';
import '../../utils/show_toast.dart';
import '../search_list/search_list.dart';
import '../../constants/colorPallete.dart';
import '../../reusable_widgets/my_text_form_field.dart';
import '../../reusable_widgets/elevated_button_widget.dart';

final _controller = Get.put(HomeController());

const double _kItemExtent = 32.0;

const List<String> beds = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
];
const List<String> bedType = <String>[
  "SingleBed",
  "DoubleBed",
  "LargeBed",
  "ExtraLargeDoubleBed",
  "BunkBed",
  "SofaBed",
  "FutonMat"
];
const List<String> price = <String>[
  '\$ 100',
  '\$ 400',
  '\$ 800',
  '\$ 1000',
  '\$ 1400',
  '\$ 1800',
  '\$ 2000',
  '\$ 2400',
  '\$ 2800',
  '\$ 3000',
  '\$ 3400',
  '\$ 3800',
  '\$ 4000',
];

class RentCard extends StatefulWidget {
  const RentCard({super.key});

  @override
  State<RentCard> createState() => _RentCardState();
}

class _RentCardState extends State<RentCard> {
  var selectedMinPrice;
  var selectedMaxPrice;
  var selectedBedType;
  int minLength = 0;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyFormField(
              controller: _controller.rentDestinationController,
              hintText: 'Enter your destination',
              hintColor: kgrey,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/search.png',
                  height: 5,
                  width: 5,
                  color: kgrey,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter correct destination";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            ...List.generate(
              2,
              (index) => Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kwhite,
                  border: Border.all(color: kgrey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: index == 0
                          ? selectedMinPrice != null && selectedMaxPrice != null
                              ? "{$selectedMinPrice} - {$selectedMaxPrice}"
                              : "Price"
                          : selectedBedType != null
                              ? "{$selectedBedType} BedType"
                              : "Beds",
                      color: index == 0
                          ? selectedMinPrice != null
                              ? kblack
                              : kgrey
                          : selectedBedType != null
                              ? kblack
                              : kgrey,
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => index == 1
                              ? bedModal()
                              : index == 0
                                  ? priceModal(context)
                                  : null,
                          child: Row(
                            children: [
                              MyText(
                                text: index == 1 ? '' : 'Min - Max',
                                size: 12.sp,
                                color: kgrey,
                                weight: FontWeight.bold,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: kgrey,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            MyButton(
              bgcolor: kprimary,
              text: 'Search',
              textColor: kwhite,
              onPress: () {
                formKey.currentState?.save();
                if (formKey.currentState!.validate()) {
                  getValues();
                  return;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void bedModal() {
    return _showDialogBeds(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: _kItemExtent,
              // This is called when selected item is changed.
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  selectedBedType = bedType[selectedItem];
                });
              },
              children: List<Widget>.generate(
                bedType.length,
                (int index) {
                  final bed = bedType[index];
                  return buildBedWidget(bed);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBedWidget(String bed) {
    switch (bed) {
      case "SingleBed":
        return const Text("Single Bed");
      case "DoubleBed":
        return const Text("Double Bed");
      case "LargeBed":
        return const Text("Large Bed");
      case "ExtraLargeDoubleBed":
        return const Text("Extra Large Double Bed");
      case "BunkBed":
        return const Text("Bunk Bed");
      case "SofaBed":
        return const Text("Sofa Bed");
      case "FutonMat":
        return const Text("Futon Mat");
      default:
        return const Text("Unknown Bed Type");
    }
  }

  Future<dynamic> priceModal(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff999999),
                    width: 0.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: MyText(
                      text: 'Cancel',
                      color: kprimary,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: MyText(
                      text: 'Select Price',
                      color: kblack,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: MyText(
                      text: 'Done',
                      color: kprimary,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {
                      // gh(selectedMinPrice,
                      //     selectedMaxPrice);;
                      Get.back();
                      // print(selectedMinPrice);
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Color(0xfff7f7f7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CupertinoButton(
                    child: MyText(
                      text: 'Min',
                      color: kprimary,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: MyText(
                      text: 'Max',
                      color: kprimary,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 160.0,
              color: Color(0xfff7f7f7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          selectedMinPrice = price[selectedItem];
                        });
                      },
                      children: List<Widget>.generate(
                        price.length,
                        (int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                price[index],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          selectedMaxPrice = price[selectedItem];
                        });
                      },
                      children: List<Widget>.generate(
                        price.length,
                        (int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                price[index],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _showDialogBeds(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff999999),
                    width: 0.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: MyText(
                      text: 'Cancel',
                      color: kprimary,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: MyText(
                      text: 'Select Beds',
                      color: kblack,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  ),
                  CupertinoButton(
                    child: MyText(
                      text: 'Done',
                      color: kprimary,
                      weight: FontWeight.w600,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 5.0,
                    ),
                  )
                ],
              ),
            ),
            Container(height: 160.0, color: Color(0xfff7f7f7), child: child)
          ],
        );
      },
    );
  }

  void getValues() {
    if (selectedMinPrice == null || selectedMaxPrice == null) {
      showToast("Kindly choose a price range", "error");
      return;
    }

    if (selectedBedType == null) {
      showToast("Kindly choose a bed type", "error");
      return;
    }

    Get.to(
      () => SearchListView(
        destination: _controller.rentDestinationController.text,
        // minPrice: selectedMinPrice,
        // maxPrice: selectedMaxPrice,
        bedPreference: selectedBedType,
        propertyType: "longStay",
      ),
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: 300),
    );
    Future.delayed(Duration(seconds: 2)).then(
      (value) => _controller.rentDestinationController.clear(),
    );
    Future.delayed(Duration(seconds: 2)).then(
      (value) => setState(
        () {
          selectedBedType = null;
          selectedMinPrice = null;
          selectedMaxPrice = null;
        },
      ),
    );
  }
}
