import 'package:flutter/material.dart';

class DesignColor {
  static Color blockHeader = Color(0xffBD1700);
  static Color cta = Color(0xff0DAEE1);
  static Color darkerWhite = Color(0xffE4D8D8);
  static Color darkestWhite = Color(0xffD7C6C6);
  static Color tinyItems = Color(0xff747576);
  static Color darkRed = Color(0xffF41D00);
  static Color lightRed = Color(0xffFF5946);
  static Color pink = Color(0xffF4988F);
  static Color lightPink = Color(0xffFADBD4);
  static Color lighterPink = Color(0xffFFECE8);
  static Color lighterRed = Color(0xffFF8E7E);
  static Color lightestBlack = Color(0xff9B9C9D);
  static const darkestGreen = Color(0xff02842E);

  static Color shimmerBackground = Colors.grey[200];
  static Color shimmerHightlight = Colors.grey[100];

  static final defaultDropShadow = [
    BoxShadow(
        color: Color(0xffFF3422).withOpacity(0.25),
        blurRadius: 5,
        offset: Offset(0, 4))
  ];

  static final backgroundColorShadow = [
    BoxShadow(
        color: Color(0xffBD1700).withOpacity(0.25),
        blurRadius: 10,
        offset: Offset(2, 2)),
  ];
  static final imageShadow = [
    BoxShadow(
        color: Color(0xff000000).withOpacity(0.25),
        blurRadius: 4,
        offset: Offset(4, 4)),
  ];
}
