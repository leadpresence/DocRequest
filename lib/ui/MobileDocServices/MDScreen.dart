import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/doctorModel.dart';
import 'package:mobiledoc/ui/requestHospitalList.dart';
import 'package:mobiledoc/widgets/payementDialog.dart';
import 'package:mobiledoc/widgets/searchDoctor.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:stacked/stacked.dart';







class MDScreen extends StatefulWidget {
  @override
  _MDScreen createState() => _MDScreen();

}

class _MDScreen extends State<MDScreen> {
  TextEditingController _destinationController = TextEditingController();
  final Key _requesScreenkey = UniqueKey();
  final Key _requesScaffoldkey = UniqueKey();


  List<String> docDeatils=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    MDAppState().initialise();
  }

  @override
  Widget build(BuildContext context) {

    //To get the arguments from the doctors list
//    docDeatils=ModalRoute.of(context).settings.arguments;
//    _destinationController.text="${docDeatils[0]}";
    Color btnColor=Colors.blueGrey;

    final appState = Provider.of<MDAppState>(context);
    Widget _floatingCollapsed() {
      return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
        ),
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Text(
            "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }



    return  ViewModelBuilder<MDAppState>.reactive(
        viewModelBuilder: ()=>MDAppState(),
          onModelReady: (model){
          MDAppState();
          },
            builder: (context,model,child)=>
                AppMenu(
               appTitle: "Request doctor",
               key: _requesScaffoldkey,
              body:appState.initialPosition == null
           ?Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   SizedBox(
                     height: 30,
                     width: 30,
                     child: CircularProgressIndicator(),
                   )
                 ],
               ),
               SizedBox(
                 height: 10,
               ),
               Visibility(
                 visible: appState.locationServiceActive == false,
                 child: Text(
                   "Please enable location service...",
                   style: TextStyle(color: Colors.grey, fontSize: 18),
                   textAlign: TextAlign.center,
                 ),
               )
             ],
           ))
           : Stack(
         key:_requesScreenkey ,
         children: <Widget>[
           GoogleMap(
             zoomGesturesEnabled: true,
             initialCameraPosition: CameraPosition(
                 target: appState.initialPosition, zoom: 16.0),
             onMapCreated: appState.onCreated,
             myLocationEnabled: true,
             mapType: MapType.terrain,
             compassEnabled: true,
             markers: appState.markers,
             onCameraMove: appState.onCameraMove,
             polylines: appState.polyLines,
             rotateGesturesEnabled: true,

           ),
//           Positioned(
//             top: 5.0,
//             right: 15.0,
//             left: 15.0,
//             child:null
//           ),

//                  Positioned(
//                    top: 105.0,
//                    right: 15.0,
//                    left: 15.0,
//                    child: Container(
//                      height: 50.0,
//                      width: double.infinity,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(3.0),
//                        color: Colors.white,
//                        boxShadow: [
//                          BoxShadow(
//                              color: Colors.grey,
//                              offset: Offset(1.0, 5.0),
//                              blurRadius: 10,
//                              spreadRadius: 3)
//                        ],
//                      ),
//                      child: TextField(
//                        cursorColor: Colors.black,
//                        controller: appState.destinationController,
//                        textInputAction: TextInputAction.go,
//                        onSubmitted: (value) {
//                          appState.sendRequest(value);
//                        },
//                        decoration: InputDecoration(
//                          icon: Container(
//                            margin: EdgeInsets.only(left: 20, top: 5),
//                            width: 10,
//                            height: 10,
//                            child: Icon(
//                              Icons.local_taxi,
//                              color: Colors.black,
//                            ),
//                          ),
//                          hintText: "destination?",
//                          border: InputBorder.none,
//                          contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
//                        ),
//                      ),
//                    ),
//                  ),

           Positioned(
             bottom: 80.0,
             left: 50,right: 50,
             child: FloatingActionButton(

              backgroundColor: Colors.black,
               child: Icon(Icons.person_pin,color: Colors.white,size: 50,),
               onPressed: (){
                 callDoctorSheet();
                 appState.getDoctors();
               },
             ),
           ),

//
         ],
       ),
    ));
  }




  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  //To handle the call  payment sheet
void callRavePaymentSheet()async{
  showModalBottomSheet<void>(
    context: context,
    builder: RavePaymentSheet,
    backgroundColor:
    Theme.of(context).scaffoldBackgroundColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(),
  );
}
//To  hold the Payment Sheet
  Widget RavePaymentSheet(BuildContext context) {
    return PaymentDialog();
  }

  Widget searchDoctorSheet(BuildContext context) {
    return SearchDoc();
  }
  //To handle the call  payment sheet
  void callDoctorSheet()async{
    showModalBottomSheet<void>(

      context: context,
      builder: searchDoctorSheet,
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
        isDismissible:true,

      shape: RoundedRectangleBorder(),
    );
  }


void h(){
  print('here we go to doctors');

}



}
