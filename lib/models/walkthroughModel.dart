import 'package:flutter/material.dart';

class WalkThrough{
  String imagePath;
  String title;
  String subTitle;
  WalkThrough({
    @required this.imagePath,
    @required this.title,
    @required this.subTitle
});



  final  splashList=[

    WalkThrough(
      imagePath: 'assets/images/walkthrough1.png',
      title: "Request Doctors",
      subTitle: "Get List Of Doctors nearby you"

    ),
    WalkThrough(
      imagePath: 'assets/images/walkthrough2.png',
      title: "Book Diagnostic",
      subTitle: "Search and book diagnostic test.",

    ),
    WalkThrough(
        imagePath: 'assets/images/walkthrough3.png',
      title: "Request Ambulance.",
      subTitle: "Request an ambulance right away with a click.",

    )


  ];




}