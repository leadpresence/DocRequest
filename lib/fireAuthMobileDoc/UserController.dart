import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/Services/authentication_services.dart';
import 'package:mobiledoc/fireAuthMobileDoc/google.dart';
import 'package:mobiledoc/locator.dart';
/*this   class interfaces Authenttication for User as well as storage and overall user information*/

class UserController{
  User _currentUser;
  Future init;

  ///initialize User
  UserController(){
    init=initUser();
  }
  //recieve the current user with a getter function
   User get currentuser => _currentUser;
   AuthenticationService _googleAuth=locator.get<AuthenticationService>();

   //User Firebase to provide current user

   Future <User> initUser() async{
//    _currentUser=await _googleAuth.getCurrentUser();
//    return _currentUser;
   }


}
