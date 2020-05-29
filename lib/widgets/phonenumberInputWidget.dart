import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/services.dart';
import 'package:mobiledoc/routes.dart';
import 'package:mobiledoc/styles.dart';
import 'package:mobiledoc/widgets/submitButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mobiledoc/fireAuthMobileDoc/fireBasePhoneAuth.dart'
    show FirebasePhoneAuth, phoneAuthState;



class OTP extends StatefulWidget {
  _OTP createState() => _OTP();
}

class _OTP extends State<OTP> {


  List<Country> countries = [];



  bool _isCountriesDataFormed = false;
  SnackBar _snackBar;
  double _textFieldHeights=80.0;

//  SnackBar _snackBar;
  final TextEditingController _controller = TextEditingController();
  final _formKeyPhoneNumber = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    final _otpformKey=GlobalKey<FormState>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        appBar:
        AppBar(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body:   Form(
          key: _otpformKey,
          child: Column(
              children: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 100,
                        height: 75,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          image: DecorationImage(
                              image: AssetImage("assets/images/verification.png"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ]),

                SizedBox(
                  height: 15.0,
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter your mobile number we will send \nyou the OTP to verify later',
                      style: TextStyle(color: lbasicGreyColor, fontSize: 12),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),

                //To hold OTP Container Content

                Wrap(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      padding: EdgeInsets.only(top: 20),

                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      width: 350,
                      height: 166,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: lbackgroundColor, style: BorderStyle.solid),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                            // has the effect of softening the shadow
                            spreadRadius: 0.0,
                            // has the effect of extending the shadow
                            offset: Offset(
                              2.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          )
                        ],
                      ),

                      //OTP TEXT Input

                      child: Form(
                        key: _formKeyPhoneNumber,
                        child: Column(
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.only(top:5.0,left: 5.0,bottom: 0.0,right:5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: 63.0,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          hintText: "+234",
                                          counter: new SizedBox(
                                            height: 0.0,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        maxLength: 4,
                                      )),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      width: 153.0,
                                      child: TextField(
                                        keyboardType: TextInputType.phone,
                                        controller: _controller,
                                        decoration: InputDecoration(
                                          hintText: "9012223344",
                                          counter: new SizedBox(
                                            height: 0.0,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        maxLength: 15,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.0,
                            ),
                            submiButton()
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              ]),
        )
    );

  }

///this is the main contentent of this screen

  Widget submiButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Container(
          width: 260,
          height: 35,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
                color: Theme.of(context).primaryColor,
                style: BorderStyle.solid),
//              color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: FlatButton(
                  onPressed: () {
                    ///Send OTP
                    if (_controller.text.length == 0 ||
                        _controller.text.length < 14) {
                      Fluttertoast.showToast(msg:"Please Check that you mobile number is complete",
                      toastLength: Toast.LENGTH_SHORT,webPosition: "top",);
                      Scaffold.of(context).showSnackBar(_snackBar);
                    } else{
                            try {
                                //instantiate phone verification
                              FirebasePhoneAuth.instantiate(phoneNumber: _controller.text);
                              Navigator.pushNamed(context, PhoneVerificationRoute);
                            } catch (e, s) {}
                    }
                  },
                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )))
    ]);
  }
}
