
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:mobiledoc/ui/viewmodels/createProfileModel.dart';
import '../models/UserModel.dart';
import 'package:stacked/stacked.dart';

//To hold the form state

List<String> newuser = List<String>();

class CompleteProfile extends StatefulWidget {
  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  void initState() {
    super.initState();
  }

  User user;
  bool emailFieldComplete = false;
  String _address, _email, _phone, _fname;
  String _lname;
  int userId;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    GlobalKey<FormState> _profileFormKey = new GlobalKey<FormState>();



    return ViewModelBuilder<CreateProfileVM>.reactive(
      viewModelBuilder: () => CreateProfileVM(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) =>

          AppMenu(
            appTitle: "Profile Details",
            body:
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: 0.01, left: 15.0, right: 15.0, bottom: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                          child: Text("Complete Profile",
                              style: _theme.textTheme.title.merge(
                                TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ),

//Complete Profile Form

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 0.1,
                        ),
                        Stack(
                          overflow: Overflow.clip,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 37.0,
                              backgroundImage:
                              AssetImage('assets/images/walkthrough1.png'),
                            ),
//
                            Positioned(
                                bottom: 1,
                                left: 40,
                                child: GestureDetector(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(150.0),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(360)),
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/small-editprofile.png'))),
                                  ),

//Listens to click event when the user wants top select a new picture
                                  onTap: () {
                                    print("edit Profile");
                                  },
                                )),
                          ],
                        ),
                        Form(
                          key: _profileFormKey,
//      autovalidate: true,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter your first Name';
                                          }
                                        },
                                        onSaved: (value) {
                                          _fname = value;
                                          _firstNameCtrl.text = value;
                                        },
                                        controller: _firstNameCtrl,
                                        keyboardType: TextInputType.text,
                                        decoration:
                                        InputDecoration(labelText: "First Name"),
                                      )),
                                ],
                              ),
                              TextFormField(
                                controller: _lastNameCtrl,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter your first last Name';
                                  }
                                },
                                onSaved: (value) {
                                  _lname = value;
                                  _lastNameCtrl.text = value;
                                },
                                keyboardType: TextInputType.text,
                                decoration:
                                InputDecoration(labelText: "Last Name"),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 80.0,
                                    child: TextFormField(
                                      keyboardType:
                                      TextInputType.numberWithOptions(
                                          signed: true),
                                      decoration: InputDecoration(
                                          labelText: "dialCode",
                                          hintText: "+234"),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty || value.length !=11) {
                                          return 'Enter valid mobile Number';
                                        }
                                      },
                                      onSaved: (value) {
                                        _phone = value;
                                        _mobileCtrl.text = value;
                                      },
                                      controller: _mobileCtrl,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                          labelText: "Mobile Number",
                                          hintText: "9012345670"),
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter your address';
                                  }
                                },
                                onSaved: (value) {
                                  _address = value;
                                  _addressCtrl.text = value;
                                },
                                controller: _addressCtrl,
                                decoration: InputDecoration(
                                    labelText: "Address",
                                    hintText: "12 lord St Mumbai,There"),
                              ),
                              TextFormField(
                                onSaved: (value) {
                                  _email = value;
                                  _emailCtrl.text = value;
                                },
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                onFieldSubmitted: (String value) {
                                  setState(() {
                                  });
                                },
                                validator: (value)=> value.contains(new RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$'))
                                    ? null
                                    : 'Enter a valid email',
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "abc@provider.com"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              agreement(),
                              SizedBox(
                                height: 10,
                              ),
                              SubmitButton(
                                color: _color,
                                btnTitle: "Register",
                                buttonWidth: 260,
                                buttonHeight: 45,
                                buttonPressed: () {
                                  print("regration started");
                                  if (_profileFormKey.currentState.validate()) {
                                    model.signUp(
                                        _emailCtrl.text,
                                        _firstNameCtrl.text,
                                        _lastNameCtrl.text,
                                        _mobileCtrl.text,
                                        _addressCtrl.text,

                                        );
                                  }


                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
            ,
          )
    );
  }

  static final RegExp nameRegExp =
      RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]'); //to check if it has any
  static final RegExp numRegExp = RegExp(r'[-!@#<>?":_`~;[\]\\|=)(a-zA-Z]');
  static final RegExp emailRegExp = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');

  Color _color = Colors.black;
  TextEditingController _addressCtrl = new TextEditingController();
  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _mobileCtrl = new TextEditingController();
  TextEditingController _firstNameCtrl = new TextEditingController();
  TextEditingController _lastNameCtrl = new TextEditingController();
}

