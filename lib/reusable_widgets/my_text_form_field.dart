import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/colorPallete.dart';

// ignore: must_be_immutable
class MyFormField extends StatelessWidget {
  final hintText;
  final TextEditingController controller;
  final validator;
  Color? hintColor;
  final obscureText;
  final prefixIcon;
  final keyboardType;
  final textInputAction;
  final focusNode;
  final nextFocusNode;
  final margin;
  final padding;
  final style;
  final decoration;
  final border;
  final enabled;
  final readonly;
  VoidCallback? ontap;
  final onSaved;
  final maxLength;
  final minLength;
  final onChanged;

  MyFormField(
      {this.hintColor,
      this.maxLength = 5,
      this.minLength = 1,
      this.ontap,
      this.readonly = false,
      this.hintText,
      required this.controller,
      this.validator,
      this.obscureText = false,
      this.prefixIcon,
      this.keyboardType,
      this.textInputAction,
      this.focusNode,
      this.nextFocusNode,
      this.margin = const EdgeInsets.all(0.0),
      this.padding = const EdgeInsets.symmetric(horizontal: 20),
      this.style,
      this.decoration = const BoxDecoration(),
      this.border,
      this.enabled = true,
      this.onSaved,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        maxLines: maxLength,
        minLines: minLength,
        onTap: ontap,
        readOnly: readonly,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: padding,
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: hintColor ?? Colors.black,
            fontSize: 12.sp,
          ),
          fillColor: kwhite,
          filled: true,
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: kblack.withOpacity(0.30),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kblack.withOpacity(0.30),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kblack.withOpacity(0.30),
            ),
          ),
        ),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: kblack,
          fontSize: 12.sp,
        ),
        enabled: enabled,
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
