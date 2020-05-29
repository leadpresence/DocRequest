import 'package:mobiledoc/Services/authentication_services.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';

import 'base_model.dart';


class PhysicalDetailsVM extends BaseModel{
  final AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  final RoutingService _navigationService = locator.get<RoutingService>();

  String title = 'default';

  void initialise() {
    title = 'initialised';
    notifyListeners();
  }


  Future<void> updatePhysicalDetails([String weight,String height,String gender])
  async {
    setBusy(true);

    var authResult = await _authenticationService.updatePhysicalDetails(
        weight: weight,
        height: height,
        gender:gender
    );
    setBusy(false);
    if (authResult ==null) {

      _navigationService.navigateTo(DobFormRoute);
    }
    else {
      print(authResult.runtimeType);
      Fluttertoast.showToast(msg: "Please Check your connectivity,try again",toastLength: Toast.LENGTH_LONG,);}
  }


}