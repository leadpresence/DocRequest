import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/fireAuthMobileDoc/google.dart';
import 'package:mobiledoc/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiledoc/Services/authentication_services.dart';

import '../locator.dart';


class GoogleLoginButton extends StatelessWidget {
  final double buttonWidth = 250.0;
  final double buttonHeight = 45.0;

  final RoutingService _navigationService = locator.get<RoutingService>();
  final AuthenticationService _authenticationService= locator.get<AuthenticationService>();

  Widget build(BuildContext context) {
    Color _color = Theme
        .of(context)
        .scaffoldBackgroundColor;

    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: this.buttonWidth,
              height: this.buttonHeight,
              decoration: BoxDecoration(
                color: _color,
                border: Border.all(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: FlatButton(
                  onPressed: () async {
                    try {
                      bool res = await _authenticationService.signInWithGoogle();
                      CircularProgressIndicator(strokeWidth: 3,backgroundColor: Colors.blueAccent,semanticsLabel: 'Please Wait...',);

                      if (!res){
                        //TODO
                        //Check and save user details
                        Fluttertoast.showToast(msg: "Google SignIn Failed Check your connection and try agian!"
                      ,toastLength: Toast.LENGTH_LONG  );

                      }
                      else{
                        //TODO check if user document in firestore has an adress field set up
                        //TODO Navigate to dashboard if address is set  if true=>dashboard Not true=>complete Profile
                        Fluttertoast.showToast(msg: "Google SignIning...");
                        _navigationService.navigateTo(MDservicesRoute);
                      }


                    } catch (e, s) {
                      print(s);
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                Icon(icon,
//                    color: butTextcolor,
//                ),
//                SizedBox(width: 5,),
                      Text('Google',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ))
                    ],
                  )))
        ]);
  }




}