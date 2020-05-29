import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/dependencies.dart';

class SubmitButton extends StatelessWidget{

  final String btnTitle;
  final double buttonHeight;
  final double buttonWidth;
  final Function  buttonPressed;
  final IconData icon;
  final double spaceBetweenIconText;
   final Color color;//=Color(0xFF0288D1);
  final Color butTextcolor=Colors.white;
   double fontSize=16.0;
   final bool active;

  SubmitButton(
      {
        @required this.btnTitle,
        this.buttonHeight,
        this.buttonWidth,
        this.buttonPressed,
        this.icon,
        this.spaceBetweenIconText=0.0,
        this.color,
        this.fontSize,
        this.active,


      });



  Widget build (BuildContext context) {


    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Container(
              width: this.buttonWidth,height: this.buttonHeight,
              decoration: BoxDecoration(
                color: color,

                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: FlatButton(
                  onPressed:this.buttonPressed,
//                      () {
//                  },
                  child:Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        btnTitle,
                        style:
                        TextStyle(color:butTextcolor,fontSize: fontSize,),
                        textAlign: TextAlign.center,

                      )
                    ],
                  )

              )
          )]);
  }



}