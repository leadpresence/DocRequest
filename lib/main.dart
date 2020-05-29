import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:mobiledoc/ui/requestDoctorsList.dart';
import 'package:mobiledoc/ui/requestHospitalList.dart';
import 'package:mobiledoc/ui/startup/startUp.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'Services/fcm_services.dart';
import 'dependencies.dart';
import 'ui_import.dart';
import 'package:provider/provider.dart';
import 'package:mobiledoc/Services/navigation_services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(mobiledoc());
  //setting Preferred orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  //setting Preferred overlays

  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);
}
class mobiledoc extends StatelessWidget {
  FcmServices _firebaseMessaging=locator<FcmServices>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
                 ChangeNotifierProvider(create: (_) => WalkthroughProvider()),
                 ChangeNotifierProvider.value(value: MDAppState(),),
                 ],
      child: MaterialApp(
        title: "mobiledoc",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData.light().copyWith(
//          primaryColor: Color(0xff0a9bf0),//blue
          primaryColor: Color(0xff05080d),//black
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
        ),
        navigatorKey: locator<RoutingService>().navigationKey,
//        initialRoute: WalkthroughRoute,
      //go to the Authservice and check if user is still signed in
      home:Startup(),
      ),
    );
  }
}

