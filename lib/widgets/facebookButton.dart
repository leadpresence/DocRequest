import 'package:flutter/rendering.dart';
import 'package:mobiledoc/routes.dart';
import 'package:mobiledoc/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class MobileButton extends StatelessWidget{
  String btnTitle;
  double buttonHeight;
  double buttonWidth;
  IconData icon ;
//  FontAwesomeIcons icons;
  Color color;
  Color butTextcolor;


  MobileButton(this.btnTitle,this.butTextcolor, [this.icon]);

  Widget build (BuildContext context) {
    color=Theme.of(context).scaffoldBackgroundColor;
    buttonWidth=250.0;
    buttonHeight=45.0;
    return Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget>[
          Container(
              width: this.buttonWidth,height: this.buttonHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid),
//              color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: FlatButton(
                onPressed: (){
                  Navigator.pushNamed(context,
                        PersonalDocumentsRoute
//                      AppRegisterRoute
                  );
                },
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                Icon(icon,
//                    color: butTextcolor,
//                ),
//                SizedBox(width: 5,),
                      Text(
                          btnTitle,style: TextStyle(color: butTextcolor,fontSize: 16,)
                      )
                    ],
                  )

              )
          )]);
  }
}