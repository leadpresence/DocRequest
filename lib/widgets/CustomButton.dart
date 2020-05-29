import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String btnTitle;
  double buttonHeight;
  double buttonWidth;
  final Function   buttonPressed;
  Icon icon;
  final Color color;
  CustomButton({this.btnTitle,
    @required this.buttonPressed,this.color
});
  @override

  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.all(5.0),
      child: FlatButton(
        onPressed: this.buttonPressed,
        child: Text(
          this.btnTitle,
          style: TextStyle(
              letterSpacing: 3.0,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      height: 35,
      width: 260,
      decoration: BoxDecoration(
        color:this.color,
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
    );
  }



}
