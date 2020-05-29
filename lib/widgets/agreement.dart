import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:mobiledoc/styles.dart';

Widget agreement(){
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(

        style:TextStyle(fontSize:10.5, color: dbasicDarkColor),
        children: <TextSpan>[

          TextSpan(text:"By continuing, I confirm that i have read & agree to the",),
          TextSpan(text: "\nTerms & conditions ",
              recognizer:new TapGestureRecognizer()..onTap = () => print('Terms'),
              style:TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: "and ",),
          TextSpan(text: "Privacy policy", style:TextStyle(fontWeight: FontWeight.bold),
            recognizer:new TapGestureRecognizer()..onTap = () => print('Policy'),

          )
        ]),
  );
}