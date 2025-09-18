import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/back_button.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';

import '../../api/booking_api.dart';
import '../../api/registration_api.dart';
import '../../constants/styles.dart';
import '../../reusable_widgets/countryCodeNumberInput.dart';
import '../../reusable_widgets/customRadioListTile.dart';
import '../../reusable_widgets/elevated_button_widget.dart';
import '../../utils/show_toast.dart';
import '../../utils/token_checker.dart';
import '../Home/home_view.dart';
import '../profile/profile_controllers/manage_your_account-controller.dart';
import '../select_rooms/body.dart';

final _controller = Get.put(ManageYourAccountController());

// ignore: must_be_immutable
class PersonalInfoView extends StatefulWidget {
  var propertyId;

  var roomId;

  var propertyType;

  var date;
  PersonalInfoView({
    super.key,
    required this.propertyId,
    required this.roomId,
    required this.propertyType,
    required this.date,
  });

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  var selectedGenderOption;
  var selectedSmokingOption;
  var selectedImageOption;
  bool loading = false;
  File? pickedImageFile;
  var selectedCode;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  updateProfile() async {
    List values = [
      _controller.firstNameController.text,
      _controller.lastNameController.text,
      _controller.mobileNumberController.text.length > 0
          ? '$selectedCode' + "${_controller.mobileNumberController.text}"
          : null,
      _controller.dobController.text,
      selectedGenderOption,
      _controller.addressController.text,
    ];
    List keys = [
      "firstName",
      "lastName",
      "mobileNumber",
      "dob",
      "gender",
      "address",
    ];

    Map<String, dynamic> data = {};
    String token = await TokenChecker().getToken();

    if (selectedGenderOption == null) {
      showToast("Select a gender", "error", gravity: ToastGravity.TOP);
      return;
    }
    print(_controller.mobileNumberController.text.length);
    if (_controller.mobileNumberController.text.length < 6) {
      showToast("Fill phone number", "error", gravity: ToastGravity.TOP);
      return;
    }

    for (int i = 0; i < keys.length; i++) {
      if (values[i] != null && values[i].length > 0) {
        data[keys[i]] = values[i];
      }
    }

    var res = await RegistrationApi().updateProfile(json.encode(data), token);
    var responseBody = res[0];
    var responseStatusCode = res[1];
    // print(responseBody);
    if (responseStatusCode == 200) {
      setState(() {
        loading = false;
      });
      showToast(
        "Profile Successfully Updated!.",
        "success",
      );
      SharedPreferences sharedStorage = await SharedPreferences.getInstance();
      await sharedStorage.remove("_user-info");
      User user = User.fromJson(
        responseBody['user'],
      );
      await sharedStorage.setString(
        '_user-info',
        jsonEncode(user),
      );
      _controller.mobileNumberController.clear();
      _controller.firstNameController.clear();
      _controller.lastNameController.clear();
      _controller.dobController.clear();
      _controller.addressController.clear();
      // selectedGenderOption

      var bookingInfo = {
        "stayStartDate": widget.date,
        "stayEndDate": widget.date,
        "propertyId": widget.propertyId,
        "roomId": widget.roomId,
        "propertyType": widget.propertyType
      };

      var bookPropertyResponse = await BookingApi.bookProperty(
        bookingInfo,
        token,
      );

      var bookingResponseBody = bookPropertyResponse[0];
      var bookingResponseStatusCode = bookPropertyResponse[1];

      if (bookingResponseStatusCode == 200) {
        var checkoutUrl = bookingResponseBody['checkoutUrl'];
        Uri checkoutParsedUri = Uri.parse(checkoutUrl);
        openURL(checkoutParsedUri);
        return;
      }

      showToast(
        "Unexpected Error!",
        "error",
      );

      return;
    } else {
      setState(() {
        loading = false;
      });

      showToast(
        "Error! ${responseBody}",
        "error",
      );

      return;
    }
  }

/* 
  Get.to(
    () => PaymentView(),
    transition: Transition.rightToLeft,
    duration: Duration(milliseconds: 300),
  );
 */
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          leading: MyBackButton(kwhite),
          title: MyText(
            text: 'Update Details',
            color: kwhite,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                profileHeading(),
                profileDetailsUpdate(),
                Divider(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: MyButton(
                    text: "Continue",
                    loading: loading,
                    textColor: kwhite,
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        updateProfile();
                        return;
                      }
                      // Get.to(
                      //   () => PaymentView(),
                      //   transition: Transition.rightToLeft,
                      //   duration: Duration(milliseconds: 300),
                      // );
                    },
                    bgcolor: kprimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container profileDetailsUpdate() {
    return Container(
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _controller.firstNameController,
            style: kblackStyle,
            decoration: InputDecoration(
              hintText: 'First Name',
              hintStyle: kgreyStyle,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter correct info";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controller.lastNameController,
            style: kblackStyle,
            decoration: InputDecoration(
              hintText: 'Last Name',
              hintStyle: kgreyStyle,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter correct info";
              }
              return null;
            },
          ),
          CountryCodeNumberInput(
            initialSelection: '+1',
            hintText: 'Mobile Number',
            controller: _controller.mobileNumberController,
            onCountryCodeChanged: (newCode) {
              print(newCode);
              setState(() {
                selectedCode = newCode;
              });
            },
          ),
          TextField(
            controller: _controller.dobController,
            style: kblackStyle,
            decoration: const InputDecoration(
              labelText: "Date Of Birth",
              labelStyle: TextStyle(color: kgrey),
            ),
            readOnly: true,
            onTap: () async {
              pickDOB();
            },
          ),
          TextFormField(
            controller: _controller.addressController,
            style: kblackStyle,
            decoration: InputDecoration(
              hintText: 'Address',
              hintStyle: kgreyStyle,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter correct info";
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              "Gender",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          CustomRadioListTile(
            title: 'Male',
            value: 'Male',
            groupValue: selectedGenderOption,
            onChanged: (value) {
              setState(() {
                selectedGenderOption = value;
              });
            },
          ),
          CustomRadioListTile(
            title: 'Female',
            value: 'Female',
            groupValue: selectedGenderOption,
            onChanged: (value) {
              setState(() {
                selectedGenderOption = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Container profileHeading() {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Profile update",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Update details to complete your booking.",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  pickDOB() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate.toIso8601String());
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      setState(() {
        _controller.dobController.text = formattedDate;
      });
    } else {
      // print("Date is not selected");
    }
  }
}
