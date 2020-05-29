import 'package:mobiledoc/Services/authentication_services.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';


import 'base_model.dart';


class RoleAndBloodGrpVM extends BaseModel{
  final AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  final RoutingService _navigationService = locator.get<RoutingService>();

  String title = 'default';

  void initialise() {
    title = 'initialised';
    notifyListeners();
  }


  Future<void> updateRoleAndBloodGrp([ String role,String group])
  async {
    setBusy(true);

    var authResult = await _authenticationService
        .updateRoleAndBloodGrp(role,group);
    setBusy(false);
    if (authResult==null) {
      _navigationService.navigateTo(DashboardRoute);
    }
    else {Fluttertoast.showToast(msg: "General  Failure,Check Connection & Please Try Again",toastLength: Toast.LENGTH_LONG,);}
  }


}