import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobiledoc/ui/dashboard.dart';
import 'package:mobiledoc/ui/onboarding/Walkthrough.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/ui_import.dart';



class Authservice{


///here we check if there is and instance of this user and
///direct the route accordingly
  GoogleSignIn _googleAuth= GoogleSignIn();

  handleAuth(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
          return snapshot.hasData?DashBoard():UnAuthenticated();
      }
    );
  }
  handleAuthWithNumber(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            //TODO get user Information ready form this and pass it into the route
            return CompleteProfile();
          }else{
            print("user notSigned in");
            return PhoneVerification();
          }
        }
    );
  }






}