import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/doctorModel.dart';

import 'base_model.dart';
import 'package:mobiledoc/Services/navigation_services.dart';


class RequestDoctorListVM extends BaseModel{
  RequestDoctorListVM(){
    getDoctors();
  }

  String title = 'mobiledoc';

  List<Doctor> _doctors;
  List<Doctor> get doctors=> _doctors;

  FirestoreServiceAPI _firestoreServiceAPI=locator.get<FirestoreServiceAPI>();
  final RoutingService _navigationService = locator.get<RoutingService>();

  void initialise() {
    title = 'Doctors';
    notifyListeners();
  }

  //TODO fetch all Doctors from the firestore API

  void getDoctors(){
    setBusy(true);
      _firestoreServiceAPI.realTimeDoctor().listen((doctorData){
        List<Doctor> updateDoctors=doctorData;
        if(updateDoctors!=null && updateDoctors.length>0){
          _doctors=updateDoctors;
          notifyListeners();
        }
        setBusy(false);
      });
  }

//     Future fetchDoctors()async {
//       try {
//         setBusy(true);
//         var doctorResult = await _firestoreServiceAPI.getDoctors();
//         setBusy(false);
//         if (doctorResult is List<Doctor>) {
//           _doctors = doctorResult;
//           notifyListeners();
//         }
//         else
//           {
//           Fluttertoast.showToast(msg: "Error loading Hospitals,try again..", toastLength: Toast.LENGTH_LONG);
//           }
//       } catch (e) {
//         print(e.message);
//       }
//     }

  void navigateToBookingDoctors(int index){
    _navigationService.navigateTo(MDservicesRoute,arguments: _doctors[index]);
  }
  void searchDoctorsList(){

  }

//TODO provide the list for the list builder on the view

//TODO handle change in the search bar

//Todo handle the ontap function on on list item

}