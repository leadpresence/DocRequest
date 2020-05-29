import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/Services/authentication_services.dart';

// to make current user to be available
final AuthenticationService _authenticationService
=locator<AuthenticationService>();
 User get currentUser => _authenticationService.currentUser;
 FirebaseUser get user=>_authenticationService.user;

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}