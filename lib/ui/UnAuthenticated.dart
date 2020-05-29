import 'package:flutter/material.dart';
import 'package:mobiledoc/styles.dart';
import 'package:mobiledoc/widgets/googleLoginButton.dart';
import 'package:mobiledoc/widgets/mobileNumberButton.dart';
import 'package:mobiledoc/widgets/facebookButton.dart';

var unauthkey=GlobalKey();

class UnAthenticated extends StatefulWidget {
  @override
  _UnAthenticatedState createState() => _UnAthenticatedState();
}

class _UnAthenticatedState extends State<UnAthenticated> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      key: unauthkey,
        body: ListView(
            children: <Widget>[
              ClipPath(
                child:
                Container(
                  width: double.infinity,
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),),
                    image: DecorationImage(
                        image: AssetImage('assets/images/hospitalNurse.png'),
                        fit: BoxFit.cover
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Center(child: Container(
                        height: 250, width: 50.0,
                        child: Image.asset('assets/images/splash.png'),
                      )
                      )
                  ),
                ),

              ),

              SizedBox(height: 35.0,),
              //butons
              MobileNumberButton(),
              SizedBox(height: 20.0,),
//              MobileButton('FaceBook',  facebookColor),
//              SizedBox(height: 20.0,),
              GoogleLoginButton(),
              SizedBox(height: 20.0,),

              Text("By continuing, you agree to Terms & Conditions",
                style: TextStyle(color: lbasicGreyColor, fontSize: 9.5,),
                textAlign: TextAlign.center,

              ),
      




            ])


    );
  }



}
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height / 4.25);
    var firstControlPoint = new Offset(size.width / 4, size.height / 3);
    var firstEndPoint = new Offset(size.width / 2, size.height / 3 - 60);
    var secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height / 4 - 65);
    var secondEndPoint = new Offset(size.width, size.height / 3 - 40);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height / 3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}