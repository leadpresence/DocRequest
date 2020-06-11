import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/doctorModel.dart';
import 'package:mobiledoc/widgets_imports.dart';

class SearchDoc extends StatefulWidget {
  _SearchDoc createState() => _SearchDoc();
}

class _SearchDoc extends State<SearchDoc> {
  static String avatar =
      'https://www.rosemaryhomes.com/wp-content/uploads/avatar-placeholder-generic-1-300x300.jpg';
  Icon icon;
  Widget appNarTitle;
  bool allowPayButton = false;
  Color btnColor = Colors.grey[200];
  var items = List<Doctor>();
  _SearchDoc({this.icon});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MDAppState>(context);

    icon = Icon(Icons.search);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: true,
            appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: true,
              elevation: 1.0,
            ),
            body: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      label(text: "You are here", style: FontWeight.normal),

                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(CupertinoIcons.location),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: TextField(
                                  textInputAction: TextInputAction.go,
                                  autofocus: false,
                                  cursorColor: Colors.black,
                                  controller: appState.locationController,
                                  decoration: InputDecoration(
                                    hintText: "Prefered Visiting address..",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 3.0, top: 16.0),
                                  ),
                                  onTap: () {
//                          callDoctorSheet();
                                  },
                                  onSubmitted: (value) {
                                    appState.locationController.text == " "
                                        ? appState.sendRequestToDoctors()
                                        : Fluttertoast.showToast(
                                            msg:
                                                "You need to enter a reachable address",
                                            toastLength: Toast.LENGTH_LONG);
                                  },
                                ),
                              ),
//                            IconButton(icon: Icon(Icons.cancel),
//                              onPressed: () {
//
//                              },
//                            ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 0.5,
                      ),

                      ///this is clicked to call the screen where you search for doctors
//                      Card(
//                        elevation: 2.0,
//                        child: Padding(
//                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Icon(Icons.search),
//                              SizedBox(
//                                width: 10.0,
//                              ),
//                              Expanded(
//                                child: TextField(
//                                  controller: appState.docSearchController,
////                                onChanged:(value){filterSearchResults(value);},
//                                  textInputAction: TextInputAction.search,
//                                  decoration: InputDecoration(
//                                      border: InputBorder.none,
//                                      hintText: "Search your Doctor"),
//                                  maxLines: 1,
//                                ),
//                              ),
//                              IconButton(icon: Icon(Icons.cancel),
//                                onPressed: () {
//
//                                },
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),

                      label(text: "Note", style: FontWeight.normal),
                      SizedBox(
                        height: 9,
                      ),

                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(CupertinoIcons.news),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: TextField(
                                  maxLines: 5,
                                  textInputAction: TextInputAction.go,
                                  autofocus: false,
                                  cursorColor: Colors.black,
                                  controller: appState.noteController,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Leave a note for incoming Medic..",
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 3.0, top: 16.0),
                                  ),
                                  onTap: () {
//                          callDoctorSheet();
                                  },
                                  onSubmitted: (value) {
                                    appState.locationController.text != null
                                        ? appState.sendRequestToDoctors()
                                        : Fluttertoast.showToast(
                                            msg:
                                                "You need to enter a reachable address",
                                            toastLength: Toast.LENGTH_LONG);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      SubmitButton(
                        buttonHeight: 40,
                        buttonWidth: 160,
                        color: btnColor,
                        btnTitle: "GO",
                        fontSize: 16,
                        buttonPressed: () {
                          appState.locationController.text != null
                              ? appState.sendRequestToDoctors()
                              : Fluttertoast.showToast(
                                  msg: "You need to enter a reachable address",
                                  toastLength: Toast.LENGTH_LONG);
                        },
                      )
//                    Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: Container(
//                          height: 244.0,
//
//                          child:
//
//                      ),
//                    ),
//                      Padding(
//                        padding: EdgeInsets.only(left: 8.0, right: 8.0
//                        ),
//                        child:
//                        Container(
//                            height: 320,
//                              child:
////                              appState.doctors != null ?
////                            ListView.builder(
////                                  itemCount: appState.doctors.length,
////                                itemBuilder: (context, index)
////                                {
////                                     return GestureDetector(
////                                        child:
////                                        DoctorListItem
////                                          (
////                                        doctor:appState.doctors[index],
////                                        ),
////                                        onTap: ()async{
////                                          appState.docSearchController.text=
////                                               appState.doctors[index].address.toString();
//////                                        appState.doctors[index].address.toString()+"\n"+
//////                                        +"\n"+appState.doctors[index].pricePerMin.toString()
////                                          print(index);
////                                          //enable pay button
////                                          allowPayButton=true;
////                                          setState(() {
//////                                          change button color
////                                              btnColor=Colors.black;
////
////                                          });
////                                          await Future.delayed(const Duration(milliseconds: 500),(){
//////                                          Navigator.pop(context);
////
////                                          });
////                                        },
////                                      );
////                                }
////
////                            )
////                                :
////                              Center(
////                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
////                                    children: <Widget>[
////                                      Text("Just wait, while  we fetch available doctors..."),
////                                      SizedBox(height: 8,),
////                                      CircularProgressIndicator(
////                                        valueColor: AlwaysStoppedAnimation(
////                                            Theme
////                                                .of(context)
////                                                .primaryColor),
////                                      ),
////                                    ],
////                                  )
////                              )
//                          StreamBuilder(
//                            stream: appState.stream,
//                            builder: (BuildContext context,
//                                AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
//                              if (snapshots.connectionState == ConnectionState.active &&
//                                  snapshots.hasData) {
//                                print('data ${snapshots.data[0].data['currentLocation']['geopoint'].latitude.toString()}');
//                                print(snapshots.runtimeType);
//                                return Container();
//                              } else {
//                                return Center(child: CircularProgressIndicator());
//                              }
//                            },
//                          ),
//                        ),
//                      ),

//                      SubmitButton(buttonHeight: 40,buttonWidth: 160,color: btnColor,
//                      btnTitle: "mobiledoc Pay",fontSize: 16,buttonPressed: (){
//                          allowPayButton?Navigator.pushNamed(context, PaymentDialogRoute):
//                              Fluttertoast.showToast(msg: "Please Select a Doctor",toastLength: Toast.LENGTH_SHORT);
//                          },)
                    ]),
              ),
            ])));
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10)
      ],
    );
  }

  Widget label({String text, FontWeight style = FontWeight.bold}) {
    return Container(
        height: 20,
        width: 90,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontWeight: style),
          ),
        ));
  }
}
