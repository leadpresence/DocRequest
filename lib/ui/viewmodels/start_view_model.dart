 import 'package:mobiledoc/Services/authentication_services.dart';
import 'package:mobiledoc/Services/fcm_services.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
 import 'base_model.dart';


class StartUpViewModel extends BaseModel{
  AuthenticationService _authenticationService=locator<AuthenticationService>();
  RoutingService _routingService =locator<RoutingService>();
  FcmServices _fcmServices=locator<FcmServices>();

   Future handleStartUp() async{
     _fcmServices.registerNotification();
     var hasUserLoggedIn= await _authenticationService.isUserSignedIn();
     if(hasUserLoggedIn){
       _routingService.navigateTo(MDservicesRoute);
     }
     else{
       _routingService.navigateTo(UnAuthenticatedPageRoute);
     }
   }








}