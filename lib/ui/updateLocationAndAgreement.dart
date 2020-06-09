import 'package:flutter/material.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:stacked/stacked.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateGeoLocation extends StatefulWidget {
  @override
  _UpdateGeoLocationState createState() => _UpdateGeoLocationState();
}

class _UpdateGeoLocationState extends State<UpdateGeoLocation> {
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MDAppState>(context);

    return ViewModelBuilder<MDAppState>.reactive(
        viewModelBuilder: () => MDAppState(),
        onModelReady: (model) => MDAppState(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text("Agreement & Conditions"),
              ),
              body: ModalProgressHUD(
                  inAsyncCall: _saving,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 50, right: 50),
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Container(
//                      color: Theme.of(context).primaryColor,
                          decoration: BoxDecoration(
                            color: Colors.black,

                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.solid),
                            //                  color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Agree To Terms & Continue',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 16.0,
                              ),
                            ),
                            onPressed: () {
                              _saving = true;
                              appState.setLocation();
                              Future.delayed(Duration(seconds: 4), () {
                                _saving = false;
                                Navigator.pushNamed(context, MDservicesRoute);
                              });
                            },
                            padding: EdgeInsets.all(6.0),
                          ),
                          width: 240, height: 55,
                        ),
                      )
                    ],
                  )),
            ));
  }
}
