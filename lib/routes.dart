import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/ui/requestDoctorsList.dart';
import 'package:mobiledoc/ui/requestHospitalList.dart';
import 'package:mobiledoc/ui/role_bloodGrp_form.dart';
import 'package:mobiledoc/ui/updateLocationAndAgreement.dart';
import 'models/doctorModel.dart';
import 'ui_import.dart';
import 'widgets_imports.dart';




//Routes

//const String MainScreenRoute = "/";
const String WalkthroughRoute = "/";
const String DashboardRoute = "Dashboard";
const String UnAuthenticatedPageRoute = "LoginView";
const String UnAthCreatAccountGoogleRoute = "createLoginView";
const String PhoneVerificationRoute = "PhoneverificationCodeScreen";
const String BankDetailsRoute = "BankDetailsView";
const String PersonalDocumentsRoute = "PersonalDocuments";
const String HomeWelcomeRoute = "HomeWelcome";
const String RequestDoctorRoute = "RequestDoctor";
const String CompleteProfileRoute = "CompleteProfile";
const String UpdateGeoLocationRoute = "updateGeo";
const String PhysicalDetailsRoute = "ProfileDetailsWHG";
const String DobFormRoute = "DobForm";
const String RoleFormRoute = "RoleForm";
const String LocationWithMapRoute = "Location";
const String MyInfoRoute = "MyInfo>";
const String ReportRoute = "DoctorsReport";
const String MDservicesRoute = "md_services";
const String AppRegisterRoute = "app_register";
const String DoctorsRoute = "doctors";
const String HospitalsRoute = "hospitals";
const String PaymentDialogRoute = "ravepay";







//Router

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
//    case MainScreenRoute:
//      return MaterialPageRoute(
//          builder: (BuildContext context) =>MainUi());
    case WalkthroughRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WalkThrough());
    case DashboardRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DashBoard());
    case UnAuthenticatedPageRoute:
      return
        MaterialPageRoute(
//          (builder: (BuildContext context) => UnAthenticated()
            settings: RouteSettings(

              name: settings.name
            ),
            builder: (BuildContext context)=>UnAuthenticated()

        );

    case UnAthCreatAccountGoogleRoute:
      return
        MaterialPageRoute(
//          (builder: (BuildContext context) => UnAthenticated()
            settings: RouteSettings(

                name: settings.name
            ),
            builder: (BuildContext context)=>UnAthCreatAccountGoogle()

        );
    case PhoneVerificationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PhoneVerification());
    case CompleteProfileRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>CompleteProfile());
    case UpdateGeoLocationRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>UpdateGeoLocation());
    case BankDetailsRoute:
      return MaterialPageRoute(
//          builder: (BuildContext context) =>BankDetails()
          settings: RouteSettings(
              name: settings.name
          ),
          builder: (BuildContext context)=>BankDetails()

      );
    case PhysicalDetailsRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>PhysicalDetails());
    case DobFormRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>DobForm());
    case RoleFormRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>RoleAndBloodGrp());
    case PersonalDocumentsRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>PersonalDocuments());
    case LocationWithMapRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>RequestDoctor());
    case MyInfoRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>Profile());
    case ReportRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>DoctorsReport());

    case MDservicesRoute:
      return MaterialPageRoute(
        settings: RouteSettings(
//          arguments:
            name: settings.name
        ),
        builder: (BuildContext context) =>MDScreen()
      );

//    case AppRegisterRoute:
//      return MaterialPageRoute(
//          builder: (BuildContext context) =>Appregister());
    case DoctorsRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>RequestDoctorsList());
    case HospitalsRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>RequestHospitalList());

    case PaymentDialogRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) =>PaymentDialog());



    default:
      return MaterialPageRoute(
          builder: (BuildContext context) =>
              Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Center(child: Column(children: <Widget>[
                  CircularProgressIndicator(strokeWidth: 4,backgroundColor: Colors.blueAccent,),
                  SizedBox(height: 10,),
                  Text("Route Not Available",style:TextStyle(fontSize: 16))
                ],),),
              ));
  }
}