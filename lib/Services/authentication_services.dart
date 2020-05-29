import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
/*this class instantiates Firebase Authentication for all the Auth Class*/

class AuthenticationService {
  FirestoreServiceAPI _firestoreServiceAPI=locator<FirestoreServiceAPI>();

    FirebaseUser user;
    FirebaseAuth auth = FirebaseAuth.instance;
  User   _currentUser;
   User get currentUser => _currentUser;
  GoogleSignIn _googleAuth= GoogleSignIn();


  singInwithPhoneNumber() {}
  signInwithEmailandPassword() {}


  Future<bool>  sinInWithGoogle() async{
    try{
      //instance of google
      GoogleSignInAccount userdetails=await _googleAuth.signIn();
    final AuthCredential _authCredential=GoogleAuthProvider.getCredential(
                          idToken: (await userdetails.authentication).idToken,
                         accessToken: (await userdetails.authentication).accessToken);

      if (userdetails==null)
        return false;
      AuthResult result=await auth.signInWithCredential(_authCredential);
      if(result.user==null)
        return false;
      return true;

    }catch(e){
      print("Error LogingIn with Google");
      return false;
    }
  }

  getCurrentUserId() async {
    String uid = (await auth.currentUser()).uid;
    return (await auth.currentUser()).uid;
  }


  //To check if user is Logged in

  Future<bool> isUserSignedIn() async {
    final currentUser = await AuthenticationService().auth.currentUser();
      if(currentUser!=null){
        await populateUserDetails(currentUser);
        return true;
      }

      else{
        return false;
      }
  }


  Future populateUserDetails(FirebaseUser user) async{
    if(user!=null){
      _currentUser=await _firestoreServiceAPI.getUserDocumentById(user.uid);
    }

  }


//to handle account creation
  Future signUpWithEmail({ String email, String firstName, String lastName, String phone,String address}) async {
    var thisUser=await auth.currentUser();
    try {
      //if the user is not existing create an account in the
      //firestore authenticated table else go on to create the users profile
      /**if(thisUser==null){
        var authResult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: email,
        );
      }*/

      _currentUser=User(
          id:thisUser.uid,
          email: thisUser.email,
          firstName: firstName,
          lastName: lastName,
          address: address,
          phone: phone,
        created_at: new Timestamp.now()
      );
    await _firestoreServiceAPI.createUser(_currentUser);
      return thisUser != null;
    }
    catch (e) {
      return e.message;
    }
  }

//  To update user bank information
  Future updateBankDetails({String bankName,String accountName,String accountNumber}) async{
    var thisUser= await auth.currentUser();
    print("user id is "+thisUser.uid);
    try{

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
      await _firestoreServiceAPI.updateUserBankInfo(_userBankDetail,thisUser.uid);
        return thisUser != null;
    }catch(e){
      print("<<Error from bank details update>> "+e);
      return e;
    }
  }
  Future updatePhysicalDetails({String weight,String height,String gender}) async{
    var result= await auth.currentUser();

    try{
      var _userBio={
        'weight':weight,
        'height':height,
        'gender':gender
      };
      await _firestoreServiceAPI.updateUserHWGInfo(_userBio, result.uid);

    }catch(e){
      print("<<Error from user WHG bio update>> "+e);

      print(e.message);
    }

  }



  Future updateAge({String age}) async{
    var result= await auth.currentUser();

    try{
      var _userAge={
        "age":age,

      };
      await _firestoreServiceAPI.updateAgeInfo(_userAge, result.uid);
    }catch(e){
      print(e.message);
    }
  }

  Future updateRoleAndBloodGrp(String role,String group) async{
    try{
      var result= await auth.currentUser();
      var _userOtherBio= {
        "role":role,
        "bloodGroup":group,
      };
      await _firestoreServiceAPI.updateRoleAndBloodGrpInfo(_userOtherBio,result.uid);
    }catch(e){
      print(e.message);
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


  Future<void> signOut() async {
    return Future.wait([
      auth.signOut(),
//      _googleAuth.signOut(),
    ]);
  }
}
