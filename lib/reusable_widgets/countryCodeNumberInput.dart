import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:stay_easy/constants/styles.dart';

class CountryCodeNumberInput extends StatelessWidget {
  final String? initialSelection;

  final String? hintText;
  final TextEditingController controller;
  final Function(String?) onCountryCodeChanged;

  CountryCodeNumberInput({
    Key? key,
    this.initialSelection,
    this.hintText,
    required this.controller,
    required this.onCountryCodeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CountryCodePicker(
          onChanged: (CountryCode? countryCode) {
            onCountryCodeChanged(countryCode?.dialCode);
          },
          initialSelection: initialSelection,
          favorite: const [
            '+1',
            '+91',
            '+234'
          ], // Optional: Specify favorite country codes
          // showCountryOnly: false,
          // showOnlyCountryWhenClosed: false,
          // alignLeft: true,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: kgreyStyle,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter correct info";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
