import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/Services/authentication_services.dart';

import 'base_model.dart';


class BankDetailsVM extends BaseModel{
  final AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  final RoutingService _navigationService = locator.get<RoutingService>();


  String title = 'default';

  void initialise() {
    title = 'initialised';
    notifyListeners();
  }


  Future<void> updateBankDetails([ String bankName, String accountName, String accountNumber])
  async {
      setBusy(true);
      var authResult = await _authenticationService.updateBankDetails(
            bankName:bankName,
            accountName:accountName,
            accountNumber:accountNumber,
      );
      setBusy(false);
      if(authResult is bool){
        print(authResult.runtimeType);
        _navigationService.navigateTo(PhysicalDetailsRoute);
      }else{
        Fluttertoast.showToast(msg: "General Signup Failure, Please Try Again",toastLength: Toast.LENGTH_LONG,);

      }

  }


}