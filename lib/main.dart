import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/services.dart';
import 'Services/dialog_services.dart';
import 'Services/fcm_services.dart';
import 'dependencies.dart';
import 'managers/dialog_manager.dart';
import 'ui_import.dart';
import 'package:provider/provider.dart';
import 'package:mobiledoc/Services/navigation_services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(Mobiledoc());
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
class Mobiledoc extends StatelessWidget {
 final FcmServices _firebaseMessaging=locator<FcmServices>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
                 ChangeNotifierProvider(create: (_) => WalkthroughProvider()),
                 ChangeNotifierProvider.value(value: MDAppState(),),
                 ],
      child: MaterialApp(
        title: "MobileDoc",
        debugShowCheckedModeBanner: false,


        builder: (context, child) => Navigator(
            key: locator<DialogService>().dialogNavigationKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => DialogManager(child: child)),
        ),
        theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Montserrat_Alternates',
//          primaryColor: Color(0xff0a9bf0),//blue
            primaryColor: Color(0xff05080d),//black
            scaffoldBackgroundColor: Color(0xFFFFFFFF),
        ),

        navigatorKey: locator<RoutingService>().navigationKey,
        onGenerateRoute: onGenerateRoute,
//        initialRoute: WalkthroughRoute,
        home:WalkThrough(),
      ),
    );
  }
}

