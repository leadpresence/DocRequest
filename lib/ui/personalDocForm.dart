import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:mobiledoc/routes.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/widgets/docFieldLabel.dart';
import 'package:mobiledoc/widgets/submitButton.dart';
import 'package:mobiledoc/styles.dart';
import 'package:mobiledoc/widgets/agreement.dart';



class PersonalDocuments extends StatefulWidget {
  @override
  _PersonalDocumentsState createState() => _PersonalDocumentsState();
}

class _PersonalDocumentsState extends State<PersonalDocuments> {

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);


    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 14,),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),

            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical:2.0),
                      child: Text(
                          "Personal Documents",
                          style:_theme.textTheme.title.merge(
                            TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                          )
                      ),
                    ),

                  ],),

                //Create Profile Form

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height:20,
                    ),
                    _peronalDetailsForm(),
                    SizedBox(height: 10,),

                    SubmitButton(color:Theme.of(context).primaryColor,
                      btnTitle: "Get Started",buttonHeight: 45,buttonWidth: 290,buttonPressed: callHomeScreen,),

                  ],)

              ],
            ),
          ),
        ));


  }
  ///* we seperate the form widget to take user
  /// * information

  Widget _peronalDetailsForm() {
    return Column(
      children: <Widget>[
        DocumentLabelField(label:"Folio Number",
          message: "This is any  valid passport of yours",),

        TextFormField(
        ),
        SizedBox(height: 8,),
        DocumentLabelField(label:"Practising Certificates",
          message: "This is any  valid passport of yours",),
        TextFormField(
        ),
        SizedBox(height:8,),
        DocumentLabelField(label:"Passport",
          message: "This is any  valid passport of yours",),
        TextFormField(
        ),
        SizedBox(height: 11,),
        agreement(),

      ],


    );
  }




  GestureRecognizer _gestureRecognizer;
  callHomeScreen(){
    Navigator.pushNamed(context,
//        RequestDoctorRoute
        DashboardRoute
    );
    print('hello');
  }
}
