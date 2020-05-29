import 'package:flutter/material.dart';

final Color lprimaryColor = const Color(0xFF0288D1);
final Color lsecondaryColor = const Color(0xffAED581);
final Color lbasicDarkColor = const Color(0xff222B45);
final Color lbasicGreyColor = const Color(0xff8F9BB3);
final Color lbackgroundColor = const Color(0xffF7F9FC);

final Color dsecondaryBlue= const Color(0xFF0A0E21);

final Color dprimaryColor = const Color(0xFF0288D1);
final Color dsecondaryColor = const Color(0xff66BB6A);
final Color dbasicDarkColor = const Color(0xff222B45);
final Color dbasicGreyColor = const Color(0xff8F9BB3);
final Color dbackgroundColor = const Color(0xff222B45);

final Color facebookColor = const Color(0xff3B5998);
final Color googlekColor = const Color(0xfff44336);

final kLabelTextStyle = TextStyle(
  fontSize: 13.0,
  color: Color(0xFF8D8E98),
);
final kNumberTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w900,
);

final double emergencyItemHeight=40.0;
final double emergencyItemWidth=70;
final double emergencyInnerItemWidth=70.0;
final double dashboardItemHeight=140.0;




// Box Decorations

BoxDecoration fieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.white);

BoxDecoration disabledFieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
const TextStyle buttonTitleTextStyle =
const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);