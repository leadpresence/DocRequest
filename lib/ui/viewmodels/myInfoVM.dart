import 'package:mobiledoc/Services/authentication_services.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/ui/myinfoScreen.dart';
import 'package:mobiledoc/ui/viewmodels/base_model.dart';

class MyInfoVm extends BaseModel{

  final AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  final RoutingService _navigationService = locator.get<RoutingService>();
  final FirestoreServiceAPI _firestoreServiceAPI= locator.get<FirestoreServiceAPI>();
  String title = 'mobiledoc';
  User _userDetails;
  User get userDetails=> _userDetails;



  void initialise() {
    title = 'My Info';
    notifyListeners();
  }




//get user by user_id
  Future<User> getUserDocumentById() async
  {
    var _user=  _authenticationService.currentUser.id;
    User data;
    setBusy(true);
    try{
       var userData= _firestoreServiceAPI.collectionReference.document(_user).get();
       await userData.then((doc) {
         data=User.fromMap(doc.data);
         _userDetails=data;

      });
      notifyListeners();

    }catch(e){
      Fluttertoast.showToast(msg: "Loading Data...",toastLength:Toast.LENGTH_SHORT);
      debugPrint("MyInfo Error ingetUserDocumentById: "+e );
      return e;
    }
    setBusy(false);
    return _userDetails;

  }

  Future <void> getUserInfo()async{
    await getUserDocumentById();
  }


//  Future <void> getUserInfo()async{
//    String _user=_authenticationService.currentUser.id;
//    print("user is"+_user.toString());
//
//    setBusy(true);
//    try{
//      await _firestoreServiceAPI.getUserDocumentById(_user).then((onValue)=
//      );
//      notifyListeners();
//    }catch(e){
//      print(e);
//    return e;
//    }
//  }



}