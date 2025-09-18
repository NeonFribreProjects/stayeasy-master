import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyContainer extends StatelessWidget {
  final child;
  final padding;
  final margin;
  final width;
  // final shadow;
  final height;
  final color;
  final decoration;
  final borderRadius;
  VoidCallback? onTap;
  // final Image image;
  final border;
  final shape;

  MyContainer({
    this.shape = BoxShape.rectangle,
    this.border,
    // this.image,
    // this.shadow,
    this.child,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
    this.width,
    this.height,
    this.color = Colors.transparent,
    this.decoration,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: child,
        padding: padding,
        margin: margin,
        width: width,
        height: height,
        decoration: decoration ??
            BoxDecoration(
              shape: shape,
              border: border,
              color: color,
              borderRadius: borderRadius,
              // boxShadow: [shadow],
              // image: DecorationImage(
              //   image: image,
              // ),
            ),
      ),
    );
  }
}
