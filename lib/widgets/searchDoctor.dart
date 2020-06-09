import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/doctorModel.dart';
import 'package:mobiledoc/widgets_imports.dart';



class SearchDoc extends StatefulWidget {
  _SearchDoc createState()=>_SearchDoc();
}


class _SearchDoc extends State<SearchDoc> {
 static String avatar='https://www.rosemaryhomes.com/wp-content/uploads/avatar-placeholder-generic-1-300x300.jpg';
  Icon icon;
  Widget appNarTitle;
  bool allowPayButton=false;
  Color btnColor=Colors.grey;
 var items = List<Doctor>();
  _SearchDoc({this.icon});


  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MDAppState>(context);

//     filterSearchResults(String query) {
//      List<Doctor> dummySearchList = List<Doctor>();
//      dummySearchList.addAll(appState.doctors);
//      if(query.isNotEmpty) {
//        List<Doctor> dummyListData = List<Doctor>();
//        dummySearchList.forEach((item) {
//          if(item.contains(query)) {
//            dummyListData.add(item);
//          }
//        });
//        setState(() {
//          items.clear();
//          items.addAll(appState.doctors);
//        });
//        return;
//      } else {
//        setState(() {
//          items.clear();
//          items.addAll(appState.doctors);
//        });
//      }
//    }

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
            body: ListView(
              children:<Widget>[
                Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          height: 20,width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey[200]
                          ),
                          child: Center(child: Text('You are Here',style: TextStyle(fontWeight: FontWeight.bold),),)),

                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 10.0,
                               ),
                              Expanded(
                                child:
                                TextField(
                                  autofocus: false,
                                  cursorColor: Colors.black,
                                  controller: appState.locationController,
                                  decoration: InputDecoration(

                                    hintText: "Prefered Visiting address..",
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(left: 3.0, top: 16.0),
                                  ),
                                  onTap: (){
//                          callDoctorSheet();
                                  },
                                 onSubmitted: (value) {
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
                      SizedBox(height: 0.5,),
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
                      SizedBox(height: 3,),
//                    Padding(
//                      padding: EdgeInsets.all(8.0),
//                      child: Container(
//                          height: 244.0,
//
//                          child: ListView.builder(
//
//                              itemCount: items.length,
//                              itemBuilder: (context, index){
//                                return Text("item $index");
//                              }
//                          )
//                      ),
//                    )
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0
                        ),
                        child:
                        Container(
                            height: 320,
                              child:
//                              appState.doctors != null ?
//                            ListView.builder(
//                                  itemCount: appState.doctors.length,
//                                itemBuilder: (context, index)
//                                {
//                                     return GestureDetector(
//                                        child:
//                                        DoctorListItem
//                                          (
//                                        doctor:appState.doctors[index],
//                                        ),
//                                        onTap: ()async{
//                                          appState.docSearchController.text=
//                                               appState.doctors[index].address.toString();
////                                        appState.doctors[index].address.toString()+"\n"+
////                                        +"\n"+appState.doctors[index].pricePerMin.toString()
//                                          print(index);
//                                          //enable pay button
//                                          allowPayButton=true;
//                                          setState(() {
////                                          change button color
//                                              btnColor=Colors.black;
//
//                                          });
//                                          await Future.delayed(const Duration(milliseconds: 500),(){
////                                          Navigator.pop(context);
//
//                                          });
//                                        },
//                                      );
//                                }
//
//                            )
//                                :
//                              Center(
//                                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Text("Just wait, while  we fetch available doctors..."),
//                                      SizedBox(height: 8,),
//                                      CircularProgressIndicator(
//                                        valueColor: AlwaysStoppedAnimation(
//                                            Theme
//                                                .of(context)
//                                                .primaryColor),
//                                      ),
//                                    ],
//                                  )
//                              )
                          StreamBuilder(
                            stream: appState.stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<DocumentSnapshot>> snapshots) {
                              if (snapshots.connectionState == ConnectionState.active &&
                                  snapshots.hasData) {
                                print('data ${snapshots.data[0].data['currentLocation']['geopoint'].latitude.toString()}');
                                print(snapshots.runtimeType);
                                return Container();
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                      ),


//                      SubmitButton(buttonHeight: 40,buttonWidth: 160,color: btnColor,
//                      btnTitle: "mobiledoc Pay",fontSize: 16,buttonPressed: (){
//                          allowPayButton?Navigator.pushNamed(context, PaymentDialogRoute):
//                              Fluttertoast.showToast(msg: "Please Select a Doctor",toastLength: Toast.LENGTH_SHORT);
//                          },)
                    ]),
              ),
            ])
        )
    );
  }
  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color:  Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10)],
    );
  }



}

