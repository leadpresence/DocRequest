import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/Services/authentication_services.dart';

import 'base_model.dart';


class DobFormVm extends BaseModel{
  final AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  final RoutingService _navigationService = locator.get<RoutingService>();

  String title = 'default';

  void initialise() {
    title = 'initialised';
    notifyListeners();
  }

  Future<void> updateAge({ String age})
  async {
    setBusy(true);
    var authResult = await _authenticationService.updateAge(age:age);
    setBusy(false);
    if (authResult == null) {
      _navigationService.navigateTo(RoleFormRoute);

    }
    else {
      print(authResult.runtimeType);
      Fluttertoast.showToast(msg: "General  Failure, Check your connection",toastLength: Toast.LENGTH_LONG,);}
  }


}