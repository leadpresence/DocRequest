import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/hospitalModel.dart';

import 'base_model.dart';
import 'package:mobiledoc/Services/navigation_services.dart';


class RequestHospitalListVm extends BaseModel {

  String title = 'mobiledoc';

  List<Hospital> _hospitals;
  List<Hospital> get hospitals=> _hospitals;

  FirestoreServiceAPI _firestoreServiceAPI=locator.get<FirestoreServiceAPI>();

  void initialise() {
    title = 'Hospitals';
    notifyListeners();
  }

  //TODO fetch all hospitals from the firestore API

void getHospitals(){
    setBusy(true);
    _firestoreServiceAPI.realTimeHospital().listen((hospitalData){
      List<Hospital> updateHospitals=hospitalData;
      if(updateHospitals!=null && updateHospitals.length>0){
      _hospitals=updateHospitals;
      print("the hospistals are :"+ hospitals.length.toString());

      notifyListeners();
      }

      setBusy(false);
    });
}

    Future navigateToBookingHospital(){}
     searchHospitalList(){
//    Fluttertoast.showToast(msg: "All Available shown already",toastLength:
//    Toast.LENGTH_LONG);
    }

//TODO provide the list for the list builder on the view

//TODO handle change in the search bar

//Todo handle the ontap function on on list item

}
//
//class DataSearch extends SearchDelegate<String>{
//
//
//}