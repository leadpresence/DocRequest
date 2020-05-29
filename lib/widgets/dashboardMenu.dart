import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Menu  extends StatelessWidget {
  String menuTitle;
  String menuImage;
  Function onPressed;

  Menu({@required this.menuImage, @required this.menuTitle, this.onPressed});
  Widget build(BuildContext context) {
    String path ="assets/images/";
    String ext =".png";
    String _path=path+menuImage+ext;

    return  Container(

      alignment: Alignment.center,
      height: 140,width: 140,
      //item content
      child: GestureDetector(
        onTap: ()=>onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //image in box
            Container(
              alignment: Alignment.center,
//              padding: EdgeInsets.all(30),
              height: 60.789,width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(

                    image: AssetImage(_path),
                    fit: BoxFit.contain
                ),

              ),
            ),
            SizedBox(height:10.0),
            Text(menuTitle,style: TextStyle(color: Colors.black,fontSize: 14),)
          ],
        ),
      ),
      //item design
      decoration:BoxDecoration (
          color: Theme.of(context).scaffoldBackgroundColor,
//          boxShadow: [
//            new BoxShadow(
//              color: Colors.lightGreenAccent,
//              blurRadius: 2.0,
//              spreadRadius: 0.08,
//              offset: new Offset(2.0, 1.0),
//            )
//          ],
          border: new Border.all(
              color: Colors.greenAccent,
              width: 0.9,
              style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))

      ),

    );
  }
}
