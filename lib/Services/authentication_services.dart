import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

import 'fcm_services.dart';
/*this class instantiates Firebase Authentication for all the Auth Class*/

class AuthenticationService {
  FirestoreServiceAPI _firestoreServiceAPI = locator<FirestoreServiceAPI>();
  FcmServices _fcmServices = locator<FcmServices>();
  FirebaseUser user;
  FirebaseAuth auth = FirebaseAuth.instance;
  User _currentUser;
  User get currentUser => _currentUser;
  GoogleSignIn _googleAuth = GoogleSignIn();

  singInwithPhoneNumber() {}
  signInwithEmailandPassword() {}

  Future<bool> sinInWithGoogle() async {
    try {
      //instance of google
      GoogleSignInAccount userdetails = await _googleAuth.signIn();
      final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
          idToken: (await userdetails.authentication).idToken,
          accessToken: (await userdetails.authentication).accessToken);

      if (userdetails == null) return false;
      AuthResult result = await auth.signInWithCredential(_authCredential);
      if (result.user == null) return false;
      return true;
    } catch (e) {
      print("Error Loging In with Google");
      return false;
    }
  }

  getCurrentUserId() async {
    String uid = (await auth.currentUser()).uid;
    return (await auth.currentUser()).uid;
  }

  //To check if user is Logged in

  Future<bool> isUserSignedIn() async {
    var  currentUser = await AuthenticationService().auth.currentUser();
    try{
     if (currentUser != null) {await populateUserDetails(currentUser);}
   }
   catch(e){debugPrint("Error populating user>>"+e.toString());}
    return user != null;


  }

  Future populateUserDetails(FirebaseUser user) async {
      print("Type>>>"+ _currentUser.runtimeType.toString());
    if (user != null) {
      //check if document with uid exist
      bool _value=await _firestoreServiceAPI.checkDocumentById(user.uid);
      //if value if true  return the doc
      if(_value){
        return _currentUser = await _firestoreServiceAPI.getUserDocumentById(user.uid);
      }
    }

  }

//to handle account creation
  Future signUpWithEmail(
      {String email,
      String firstName,
      String lastName,
      String phone,
      String address}) async {
    var thisUser = await auth.currentUser();
    try {
      //if the user is not existing create an account in the
      //firestore authenticated table else go on to create the users profile
      /**if(thisUser==null){
        var authResult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: email,
        );
      }*/

      Map _cur={'geohash': MDAppState().geoFirePoint.data['geohash']
        ,'geopoint':[{'latitude':MDAppState().geoFirePoint.data['latitude'],
          'longitude':MDAppState().geoFirePoint.data['longitude']}]};

      _currentUser = User(
          id: thisUser.uid,
          email: thisUser.email,
          firstName: firstName,
          lastName: lastName,
          address: address,
          phone: phone,
          created_at: FieldValue.serverTimestamp(),
        pushToken: _fcmServices.ktoken,// optional
          currentLocation: "_cur"

      );
      await _firestoreServiceAPI.createUser(_currentUser);
//      await MDAppState().updateLocation();
      return thisUser != null;

    } catch (e) {
       debugPrint("Error in account creation:"+e.toString());
      return e;
    }
  }



  //!To check if User exits in a spectic firstore document

  getRegisteredUser()async{
    var thisUser = await auth.currentUser();

   var _value=await _firestoreServiceAPI.checkDocumentById(thisUser.uid);

   return _value;



  }




//  To update user bank information
  Future updateBankDetails(
      {String bankName, String accountName, String accountNumber}) async {
    var thisUser = await auth.currentUser();
    print("user id is " + thisUser.uid);
    try {
//      _currentUser= User(
//          bankName:bankName,
//          accountName:accountName,
//          accountNumber:accountNumber
//      );
      var _userBankDetail = {
        'bankName': bankName,
        'accountName': accountName,
        'accountNumber': accountNumber
      };
      await _firestoreServiceAPI.updateUserBankInfo(
          _userBankDetail, thisUser.uid);
      return thisUser != null;
    } catch (e) {
      print("<<Error from bank details update>> " + e);
      return e;
    }
  }

  Future updatePhysicalDetails(
      {String weight, String height, String gender}) async {
    var result = await auth.currentUser();

    try {
      var _userBio = {'weight': weight, 'height': height, 'gender': gender};
      await _firestoreServiceAPI.updateUserHWGInfo(_userBio, result.uid);
    } catch (e) {
      print("<<Error from user WHG bio update>> " + e);
    }
  }

    Future updateAge({String age}) async {
      var result = await auth.currentUser();

      try {
        var _userAge = {
          "age": age,
        };
        await _firestoreServiceAPI.updateAgeInfo(_userAge, result.uid);
      } catch (e) {
        print(e.message);
      }
    }

    Future updateRoleAndBloodGrp(String role, String group) async {
      try {
        var result = await auth.currentUser();
        var _userOtherBio = {
          "role": role,
          "bloodGroup": group,
        };
        await _firestoreServiceAPI.updateRoleAndBloodGrpInfo(
            _userOtherBio, result.uid);
      } catch (e) {
        debugPrint("Error in updating:" + e);
      }
    }

//
//  Future <void> getUserInfo()async{
//    var result= await auth.currentUser;
//
//    try{
//      User userInfo= await _firestoreServiceAPI.getUserDocumentById(_user)
//
//      print(userInfo);
//    }catch(e){
//      print(e);
//      }

    Future<bool> checkUserPush() async {
      Future<bool> hasPushToken;
      var userId = currentUser.id;
      var res = await _firestoreServiceAPI.getUserDocumentById(userId);
      res.forEach((DocumentSnapshot doc) {
        doc.data['pushToken'] != null
            ? hasPushToken = true as Future<bool>
            : hasPushToken = false as Future<bool>;
      });
      return hasPushToken;
    }

    Future<void> signOut() async {
      return Future.wait([
        auth.signOut(),
//      _googleAuth.signOut(),
      ]);
    }
  }