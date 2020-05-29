import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:mobiledoc/ui/viewmodels/bankDetailsModel.dart';
import 'package:flutter/cupertino.dart';

import 'package:stacked/stacked.dart';

//To hold the form state

//inotialize the provider service
//UserRegistration _userRegistration;

class BankDetails extends StatefulWidget {
  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  String _bankName, _accountName, _accountNum;
  GlobalKey<FormState> _bankFormKey = new GlobalKey<FormState>();
  bool emailFieldComplete = false;
  Color _color = Colors.grey;
  @override
  Widget build(BuildContext context) {
//    _userRegistration = Provider.of<UserRegistration>(context);
    final ThemeData _theme = Theme.of(context);



    return ViewModelBuilder<BankDetailsVM>.reactive(
      viewModelBuilder: () => BankDetailsVM(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 14,
              ),
              onPressed: () {
                try {
                  if (Navigator.of(context).canPop()) {
//                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, CompleteProfileRoute);

                  }
                } catch (e) {
                  print("You have this error on Navigation ${e}");
                  Fluttertoast.showToast(
                      msg: "Sorry you can only edit Previous from my Info menu",
                      toastLength: Toast.LENGTH_LONG);
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Text("Bank Details",
                            style: _theme.textTheme.title.merge(
                              TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),

                  //Create Profile Form

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _bankFormKey,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: _bankNameCtrl,
                                    validator: (val) => val.isEmpty
                                        ? 'Enter your bank\'s name'
                                        : null,
                                    onSaved: (value) {
                                      _bankName = value;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: "Bank Name",
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Enter the Name of your prefered bank");
                                            },
                                            icon: Icon(
                                              Icons.info_outline,
                                              color: Colors.blueGrey,
                                              size: 20,
                                            ))),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _accountNameCtrl,
                              validator: (val) => val.isEmpty
                                  ? 'Enter your account holder\'s name'
                                  : null,
                              onSaved: (value) {
                                _accountName = value;
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: "Account Holder Name",
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg:
                                                "This Show be Exact names of the provided Account");
                                      },
                                      icon: Icon(Icons.info_outline,
                                          color: Colors.blueGrey, size: 20))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _accountNumberCtrl,
                              validator: (val) =>
                                  (val.isEmpty || val.length != 10)
                                      ? 'Enter your account number'
                                      : null,
                              onSaved: (value) {
                                _accountNum = value;
                                String valueToStr = value.toString();
//                                _userRegistration.addAccNum(valueToStr);
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Account Number",
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Enter the 1 Digits of Bank Account");
                                      },
                                      icon: Icon(Icons.info_outline,
                                          color: Colors.blueGrey, size: 20))),
                              onChanged: (String value) {
                                setState(() {
                                  value.length == 10
                                      ? _color = Theme.of(context).primaryColor
                                      : _color = Colors.grey;
                                });
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            agreement(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      SubmitButton(
                        color: _color,
                        btnTitle: "NEXT",
                        buttonHeight: 45,
                        buttonWidth: 270,

                        buttonPressed: () {
                          if (_bankFormKey.currentState.validate()) {
                            _bankFormKey.currentState.save();
                            model.updateBankDetails(
                                 _bankNameCtrl.text,
                                _accountNameCtrl.text,
                                _accountNumberCtrl.text
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
  TextEditingController _bankNameCtrl= new TextEditingController();
  TextEditingController _accountNameCtrl= new TextEditingController();
  TextEditingController _accountNumberCtrl= new TextEditingController();

}

//TODO from here navigaet e to select weigh height and gender PhysicalDetailsRoute
