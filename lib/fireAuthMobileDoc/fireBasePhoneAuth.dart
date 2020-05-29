import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobiledoc/Services/firestore_services.dart';
import '../Services/authentication_services.dart';
import 'package:mobiledoc/dependencies.dart';

  enum PhoneAuthState {
    Started,
    CodeSent,
    CodeResent,
    Verified,
    Failed,
    Error,
    AutoRetrievalTimeOut
  }

class FirebasePhoneAuth {
  static var _authCredential, actualCode, phone, status;
  static StreamController<String> statusStream = StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState = StreamController.broadcast();
  static Stream stateStream = phoneAuthState.stream;
  AuthenticationService _auth=locator.get<AuthenticationService>();

  FirebasePhoneAuth();

  static instantiate({String phoneNumber}) async {
    assert(phoneNumber != null);
    phone = phoneNumber;
    print(phone);
    startAuth();
  }

  static dispose() {
//    statusStream.close();
//    phoneAuthState.close();
  }


  static startAuth() {
    statusStream.stream
        .listen((String status) => print("PhoneAuth: " + status));
    addStatus('Phone auth started');
    AuthenticationService().auth
        .verifyPhoneNumber(
        phoneNumber: phone.toString(),
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        forceResendingToken: actualCode,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      addStatus('Code sent');

    }).catchError((error) {
//      Fluttertoast.showToast(msg: "")
      addStatus(error.toString());
    });
  }

  static final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("\nEnter the code sent to " + phone);
    addState(PhoneAuthState.CodeSent);
  };

  static final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
    addState(PhoneAuthState.AutoRetrievalTimeOut);
  };

  static final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
    addStatus('${authException.message}');
    addState(PhoneAuthState.Error);
    if (authException.message.contains('not authorized'))
      addStatus('App not authroized');
    else if (authException.message.contains('Network'))
      addStatus('Please check your internet connection and try again');
    else
      addStatus('Something has gone wrong, please try later ' +
          authException.message);
  };

  static final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential auth) {
    addStatus('Auto retrieving verification code');
    AuthenticationService().auth.signInWithCredential(auth)
         .then((AuthResult value) {
      if (value.user != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful();
      }


      else {
        addState(PhoneAuthState.Failed);
        addStatus('Invalid code/invalid authentication');
      }
    }
    ).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Something has gone wrong, please try later $error');
    });
      };



  //SignIn user with mobile   OTP
  static void signInWithPhoneNumber({String smsCode}) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    AuthenticationService().auth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {
      //create user record in firebase with the Dataservice class uid
      print(result.user.uid);
      print(phone);
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful();

    }


    ).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');

    });
  }

  static onAuthenticationSuccessful()async {
    stateStream.listen((value){
      if (value==PhoneAuthState.Verified) {
          return true;
      }
        return true;
    });
  }


  static Future<void> signOutPhone() async {
    return Future.wait([
      AuthenticationService().auth.signOut(),
    ]);
  }

  static addState(PhoneAuthState state) {

    print(state);
    phoneAuthState.sink.add(state);
  }

  static void addStatus(String s) {
    statusStream.sink.add(s);
    print(s);
    Fluttertoast.showToast(msg: s,toastLength: Toast.LENGTH_LONG);
  }

  static void closeSink(){
    statusStream.close();
    phoneAuthState.close();
  }
}