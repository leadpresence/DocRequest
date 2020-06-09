import 'package:flutter/material.dart';
import 'package:mobiledoc/styles.dart';
import 'package:mobiledoc/widgets/googleLoginButton.dart';
import 'package:mobiledoc/widgets/mobileNumberButton.dart';
import 'package:mobiledoc/widgets/facebookButton.dart';

var unauthkey=GlobalKey();

class UnAuthenticated extends StatefulWidget {
  @override
  _UnAuthenticatedState createState() => _UnAuthenticatedState();
}
class _UnAuthenticatedState extends State<UnAuthenticated> {
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
