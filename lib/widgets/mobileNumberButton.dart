import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/widgets/phonenumberInputWidget.dart';

class MobileNumberButton extends StatelessWidget {
  String btnTitle;
  double buttonHeight;
  double buttonWidth;
  Function buttonPressed;
  IconData icon;
//  FontAwesomeIcons icons;
  Color color;
  Color butTextcolor;
  Widget OTPSheet(BuildContext context) {
    return OTP();
  }

  Widget build(BuildContext context) {
    color = Theme.of(context).scaffoldBackgroundColor;
    buttonWidth = 250.0;
    buttonHeight = 45.0;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: this.buttonWidth,
              height: this.buttonHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid),
//              color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: FlatButton(
                  color: Colors.transparent,
                  onPressed: () async {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: OTPSheet,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                Icon(icon,
//                    color: butTextcolor,
//                ),
//                SizedBox(width: 5,),
                      Text('Mobile Number',
                          style: TextStyle(
                            color: butTextcolor,
                            fontSize: 16,
                          ))
                    ],
                  )))
        ]);
  }
}
