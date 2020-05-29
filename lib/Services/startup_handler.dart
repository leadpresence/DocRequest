import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';

import '../locator.dart';
import 'authentication_services.dart';

class StartUpHandler{

  AuthenticationService _authenticationService=locator.get<AuthenticationService>();
  RoutingService _routingService= locator.get<RoutingService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserSignedIn();
    if (hasLoggedInUser) {
      _routingService.navigateTo(DashboardRoute);
    } else {
      _routingService.navigateTo(UnAuthenticatedPageRoute);
    }
  }
}


