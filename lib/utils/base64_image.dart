import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Base64Image extends StatelessWidget {
  final String base64String;
  var height;
  var width;

  Base64Image({required this.base64String, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(base64String);
    return Image.memory(
      bytes,
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
