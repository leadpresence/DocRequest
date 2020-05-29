import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobiledoc/dependencies.dart';

import '../locator.dart';
import 'navigation_services.dart';

class FcmServices{


  FirebaseMessaging firebaseMessaging=FirebaseMessaging();
  RoutingService _routingService =locator<RoutingService>();


  FcmServices(){registerNotification();}

  void registerNotification() {
    firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
      print('onMessage: $message');
//      Platform.isAndroid ? showNotification(message['notification']) : showNotification(message['aps']['alert']);
      return;
    }, onResume: (Map<String, dynamic> message) {
      print('onResume: $message');
      serializeNavigate(message);
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      print('onLaunch: $message');
      serializeNavigate(message);

      return;
    });
//
//    firebaseMessaging.getToken().then((token) {
//      print('token: $token');
//      Firestore.instance.collection('users').document(currentUserId).updateData({'pushToken': token});
//    }).catchError((err) {
//      Fluttertoast.showToast(msg: err.message.toString());
//    });
  }

  setPushToken(){
          var _pushtoken;
          var result=firebaseMessaging.getToken().then((token) {
            _pushtoken=token;
          });
          debugPrint(_pushtoken);
          print (_pushtoken);
          return _pushtoken;
  }

  //To set a message with a key view on click of the notification routes to the
  //RequestDoctorRoute screen
  void serializeNavigate(Map<String, dynamic> message){
    var notificationData=message['data'];
    var view=notificationData['New_request'];
    if(view!=null){
      _routingService.navigateTo(RequestDoctorRoute);
    }

  }
}