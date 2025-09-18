import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? size;
  final weight;
  final color;
  final align;
  final decoration;
  final fontFamily;
  final maxLines;
  final wrappable;

  const MyText({
    required this.text,
    this.size = 14.0,
    this.weight = FontWeight.normal,
    this.color = Colors.black,
    this.align = TextAlign.left,
    this.decoration,
    this.fontFamily,
    this.maxLines = 1,
    this.wrappable = false,
  });

  @override
  Widget build(BuildContext context) {
    return wrappable
        ? Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: color,
              decoration: decoration,
              fontFamily: fontFamily,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: align,
            maxLines: maxLines,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          )
        : Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: weight,
              color: color,
              decoration: decoration,
              fontFamily: fontFamily,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: align,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );
  }
}
