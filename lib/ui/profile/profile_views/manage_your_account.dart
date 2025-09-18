import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stay_easy/api/registration_api.dart';
import 'package:stay_easy/constants/styles.dart';
import 'package:stay_easy/reusable_widgets/back_button.dart';
import 'package:stay_easy/reusable_widgets/countryCodeNumberInput.dart';
import 'package:stay_easy/reusable_widgets/customRadioListTile.dart';
import 'package:stay_easy/ui/profile/profile_controllers/manage_your_account-controller.dart';
// import 'package:stay_easy/utils/is_email.dart';
import 'package:stay_easy/utils/token_checker.dart';
// import 'package:stay_easy/ui/sign_or_create/sign_or_create.dart';

import '../../../constants/colorPallete.dart';
import '../../../reusable_widgets/elevated_button_widget.dart';
import '../../../reusable_widgets/my_text_widget.dart';
import '../../../utils/base64_image.dart';
import '../../../utils/show_toast.dart';

final _controller = Get.put(ManageYourAccountController());

class ManageYourAccount extends StatefulWidget {
  const ManageYourAccount({super.key});

  @override
  State<ManageYourAccount> createState() => _ManageYourAccountState();
}

class _ManageYourAccountState extends State<ManageYourAccount> {
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
      _controller.emailController.text,
      _controller.passController.text,
      _controller.firstNameController.text,
      _controller.lastNameController.text,
      _controller.mobileNumberController.text.length > 0
          ? '$selectedCode' + "${_controller.mobileNumberController.text}"
          : null,
      _controller.dobController.text,
      selectedGenderOption,
      _controller.addressController.text,
      // selectedSmokingOption,
      // selectedImageOption
    ];
    List keys = [
      "email",
      "password",
      "firstName",
      "lastName",
      "mobileNumber",
      "dob",
      "gender",
      "address",
      // "smokingPreference",
      // "profilePic"
    ];

    Map<String, dynamic> data = {};
    String token = await TokenChecker().getToken();

    for (int i = 0; i < keys.length; i++) {
      if (values[i] != null && values[i].length > 0) {
        data[keys[i]] = values[i];
      }
    }
    var res = await RegistrationApi().updateProfile(json.encode(data), token);
    var responseBody = res[0];
    var responseStatusCode = res[1];
    print(responseStatusCode);
    if (responseStatusCode == 200) {
      setState(() {
        loading = false;
      });
      showToast("Profile Successfully Updated!.", "success");

      _controller.mobileNumberController.clear();
      _controller.emailController.clear();
      _controller.passController.clear();
      _controller.firstNameController.clear();
      _controller.lastNameController.clear();
      _controller.dobController.clear();
      _controller.addressController.clear();
      // selectedGenderOption
      setState(() {
        selectedImageOption = null;
      });
      return;
    } else {
      setState(() {
        loading = false;
      });
      showToast("Error! ${responseBody['message']}", "error");
      return;
    }
  }

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
            text: 'Your Details',
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: MyButton(
                    text: "Update",
                    loading: loading,
                    textColor: kwhite,
                    onPress: () {
                      if (selectedImageOption != null ||
                          selectedGenderOption != null) {
                        updateProfile();
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        updateProfile();
                        // print('$selectedCode' +
                        // "${_controller.mobileNumberController.text}");
                        return;
                      }
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
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TextFormField(
          //   style: kblackStyle,
          //   controller: _controller.emailController,
          //   decoration: InputDecoration(
          //     hintText: 'Email Address',
          //     hintStyle: kgreyStyle,
          //   ),
          //   validator: (value) {
          //     if (value == null) return null;
          //     if (value == "") return null;
          //     if (!isEmail(value)) {
          //       return "Incorrect email format";
          //     }
          //     return null;
          //   },
          // ),

          TextFormField(
            controller: _controller.passController,
            style: kblackStyle,
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: kgreyStyle,
            ),
            obscureText: true,
            maxLines: 1,
            minLines: 1,
            validator: (value) {
              if (value == null) return null;
              if (value == "") return null;
              if (value.length < 5) {
                return 'Your password must be at least 5 charaters.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _controller.firstNameController,
            style: kblackStyle,
            decoration: InputDecoration(
              hintText: 'First Name',
              hintStyle: kgreyStyle,
            ),
          ),
          TextFormField(
            controller: _controller.lastNameController,
            style: kblackStyle,
            decoration: InputDecoration(
              hintText: 'Last Name',
              hintStyle: kgreyStyle,
            ),
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
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
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
          // Text(
          //   "Smoking Preference",
          //   style: TextStyle(
          //     fontSize: 20.0,
          //   ),
          //   textAlign: TextAlign.left,
          // ),
          // CustomRadioListTile(
          //   title: 'Smoking',
          //   value: 'Smoking',
          //   groupValue: selectedSmokingOption,
          //   onChanged: (value) {
          //     setState(() {
          //       selectedSmokingOption = value;
          //     });
          //   },
          // ),
          // CustomRadioListTile(
          //   title: 'No Smoking',
          //   value: 'NoSmoking',
          //   groupValue: selectedSmokingOption,
          //   onChanged: (value) {
          //     setState(() {
          //       selectedSmokingOption = value;
          //     });
          //   },
          // ),
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
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          InkWell(
            onTap: () {
              scaffoldKey.currentState!.showBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                (context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: Get.width,
                      height: 150.h,
                      decoration: BoxDecoration(
                        color: kprimary.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.h),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        size: 40.sp,
                                        color: kprimary,
                                      ),
                                      SizedBox(height: 10.h),
                                      MyText(text: "Camera")
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 40.sp,
                                        color: kprimary,
                                      ),
                                      SizedBox(height: 10.h),
                                      MyText(text: "Gallery")
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xffc2c2c2)),
              ),
              child: selectedImageOption != null
                  ? Base64Image(
                      base64String: selectedImageOption,
                      height: 40.h,
                    )
                  : Image.asset(
                      'assets/images/avatar.png',
                      height: 40.h,
                    ),
            ),
          ),
          SizedBox(height: 10),
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
      // print(formattedDate);

      setState(() {
        _controller.dobController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  Future<String> pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      // Convert the selected image to base64
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      Navigator.of(scaffoldKey.currentContext!).pop();
      print(base64Image);
      setState(() {
        selectedImageOption = base64Image;
      });
      return base64Image;
    } else {
      print("base64Image not selected");

      // No image was selected
      return '';
    }
  }
}
