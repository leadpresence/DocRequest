import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/fireAuthMobileDoc/fireBasePhoneAuth.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/widgets_imports.dart';



/*From the phone input widgets widgests>phoneInput
* */


class PhoneVerification extends StatefulWidget {
  _PhoneVerification createState()=>_PhoneVerification();}

  class _PhoneVerification extends State<PhoneVerification>{
    final RoutingService _navigationService = locator.get<RoutingService>();




    double _height, _width, _fixedPadding;
    FocusNode focusNode1 = FocusNode();
    FocusNode focusNode2 = FocusNode();
    FocusNode focusNode3 = FocusNode();
    FocusNode focusNode4 = FocusNode();
    FocusNode focusNode5 = FocusNode();
    FocusNode focusNode6 = FocusNode();
    String code = "";

    @override
    void initState() {

      Authservice().handleAuthWithNumber();

    // Check if the auto authentication has been done and route to the profile page
      FirebasePhoneAuth.phoneAuthState.stream
          .listen((PhoneAuthState state) {
           print(state);
          if(state==PhoneAuthState.Verified){
          Navigator.pushNamed(context, MDservicesRoute);
        }

      });
      super.initState();
  }



  @override
  Widget build(BuildContext context) {

    _callCreateProfileScreen() {
//      Navigator.pushNamed(context, CreateProfileRoute);
    }

    final ThemeData _theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: _theme.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 14,),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child:getContent())

    );}

          Widget getContent(){
            return Column
           (
            children: <Widget>[
              //To hold Verification Image
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text('Enter code', style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),),
                    ),

                  ]),
              SizedBox(height: 8.0,),
              //Top image
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text('* * * * * *', style: TextStyle(
                          color: Colors.green,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),),
                    ),

                  ]),


            //Top message
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  Text(
                    'We have sent you an SMS \nw ith 6 digit verification code.',
                    style: TextStyle(color: lbasicGreyColor, fontSize: 12),
                    textAlign: TextAlign.center,)
                ],
              ),
              SizedBox(height: 5.0,),
              //To hold OTP Container
            Wrap(
            children: <Widget>[
            Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
                  child:
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 330,
                      height: 176,
                      decoration: BoxDecoration(

                        border: Border.all(
                            color: lbackgroundColor,
                            style: BorderStyle.solid),
                        color: Theme
                            .of(context)
                            .scaffoldBackgroundColor,
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

                      child: Column(
                        children: <Widget>[
                          new Container(
                            margin: const EdgeInsets.only(
                                top: 25.5, bottom: 20, left: 20, right: 20),
                            child:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                getPinField(key: "1", focusNode: focusNode1),
                                SizedBox(width: 5.0),
                                getPinField(key: "2", focusNode: focusNode2),
                                SizedBox(width: 5.0),
                                getPinField(key: "3", focusNode: focusNode3),
                                SizedBox(width: 5.0),
                                getPinField(key: "4", focusNode: focusNode4),
                                SizedBox(width: 5.0),
                                getPinField(key: "5", focusNode: focusNode5),
                                SizedBox(width: 5.0),
                                getPinField(key: "6", focusNode: focusNode6),
                                SizedBox(width: 5.0),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.05,),
                          //Submit OTP Button
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>
                            [
                                SubmitButton(color:Colors.blue,btnTitle: "Submit",
                                    buttonWidth: 250,
                                    buttonHeight: 40,
//                                    buttonPressed:()=>signIn
                                    buttonPressed:(){
                                      signIn();
                                    }
                                )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              SizedBox(height: 45,),


              //Questions ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Did you not recieve the code ?", style: TextStyle(
                      fontSize: 14,
                      color: Colors.black
                  ),),
                ],),
              SizedBox(height: 5.0,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child:
                    FlatButton(
                      child: Text("Resend", style: TextStyle(
                          fontSize: 14,
                          color: Theme
                              .of(context)
                              .primaryColor
                      ),),
                      onPressed: () {
                        //Force resend OTP
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),),
//              SizedBox(width: 0.3,),
                    Expanded(
                      child: FlatButton(
                        child: Text("Get a call now", style: TextStyle(
                            fontSize: 13,
                            color: Theme
                                .of(context)
                                .primaryColor
                        ),),

                        //TODO Get A Call
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Unavailable, Kindly try resend option");

                        },
                      ),
                    ),
                  ]),

            ],)
            ]);

  }

    /*SignIn user to complete plrofile
    * when the stream has changed to verified
    * Also test if the leght is !=6*/



    signIn() {

      if (code.length != 6)
      {
        Fluttertoast.showToast(msg: "Ensure you have entered the right code or try after one minuite");
      }
      //this verifies client and sets stream state to verified
      FirebasePhoneAuth.signInWithPhoneNumber(smsCode: code);
      //Once stream value is verified move to profile creation
      FirebasePhoneAuth.stateStream.listen((value){
      if(value==PhoneAuthState.Verified){
        _navigationService.navigateTo(MDservicesRoute);
      }
      });
    }


// This will return pin field - it accepts only single char
    Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
      height: 40.0,
      width: 35.0,
      child: TextField(
        key: Key(key),
        expands: false,
        autofocus: key.contains("1") ? true : false,
        focusNode: focusNode,
        onChanged: (String value) {
          if (value.length == 1) {
            code += value;
            switch (code.length) {
              case 1:
                FocusScope.of(context).requestFocus(focusNode2);
                break;
              case 2:
                FocusScope.of(context).requestFocus(focusNode3);
                break;
              case 3:
                FocusScope.of(context).requestFocus(focusNode4);
                break;
              case 4:
                FocusScope.of(context).requestFocus(focusNode5);
                break;
              case 5:
                FocusScope.of(context).requestFocus(focusNode6);
                break;
              default:
                FocusScope.of(context).requestFocus(FocusNode());
                break;
            }
          }
        },
        maxLengthEnforced: false,
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );



}