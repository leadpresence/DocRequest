import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/Services/authentication_services.dart';

import 'base_model.dart';


class CreateProfileVM extends BaseModel{
  final AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  final RoutingService _navigationService = locator.get<RoutingService>();

  String title = 'default';

  void initialise() {
    title = 'initialised';
    notifyListeners();
  }


  Future<void> signUp([ String email,String firstName,String lastName,String phone, String address])
  async {
    setBusy(true);
    var authResult = await _authenticationService.signUpWithEmail(
           email: email,
           firstName: firstName,
           lastName: lastName,
           address: address,
           phone: phone

      );
    setBusy(false);
      if (authResult is! String ) {
        _navigationService.navigateTo(MDservicesRoute);

//        if (authResult) {
//          _navigationService.navigateTo(BankDetailsRoute);
//        } else {
//
//
//          Fluttertoast.showToast(msg: "General Signup Failure, Please Try Again",
//              toastLength: Toast.LENGTH_LONG,textColor: Colors.redAccent);
//
//        }
      }
      else {
        Fluttertoast.showToast(msg: "General Signup Failure, Please Try Again ${authResult.toString()}",toastLength: Toast.LENGTH_LONG,);
      }
  }


}