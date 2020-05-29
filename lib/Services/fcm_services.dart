import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FcmServices{
  FirebaseMessaging firebaseMessaging=FirebaseMessaging();

  FcmServices(this.firebaseMessaging);

}