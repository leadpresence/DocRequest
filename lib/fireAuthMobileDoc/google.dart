import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/Services/firestore_services.dart';
import '../Services/authentication_services.dart';
//import 'authentication_services.dart';

/*To handle Google Auth
*
*
* */
class GoogleAuth{
  // Dependencies
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleAuth= GoogleSignIn();
  DateTime _created_at= new DateTime.now();
  final AuthenticationService _authenticationService=locator<AuthenticationService>();



  Future<bool>  sinInWithGoogle() async{
    try{
      //instance of google
      GoogleSignInAccount _userdetails=await _googleAuth.signIn();

      if (_userdetails ==null)
         return false;
        AuthResult result=await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
                                                            idToken: (await _userdetails.authentication).idToken,
                                                            accessToken: (await _userdetails.authentication).accessToken)
                                                          );
        //create new record firestore for this user
      //TODO get current user snapshot and compare email if they are not equal perform the next line

      if(result.user==null)
          return false;
      return true;
    }catch(e){
      print("Error LogingIn with Google");
      return false;
    }
  }




///this gets our current User and attahes it to our user model
//  Future<User> getUser() async{
//    var firebaseuser= await _auth.currentUser();
//  return User(id:firebaseuser.uid,firstName: firebaseuser.displayName,email: firebaseuser.email);
//
//  }

}

