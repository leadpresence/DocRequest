import 'package:cloud_firestore/cloud_firestore.dart';
class Request{
  Timestamp startAt;
  Timestamp finishedAt;
  String requestId;
  String patientName;
  String patientAddress;
  String patientPhone;
  String doctorName;
  String doctorAddress;
  String doctorPhone;
  int acceptedFlag=0;

  Request({this.startAt,this.finishedAt,
  this.patientName,this.patientAddress,
  this.patientPhone,this.doctorName,
  this.doctorAddress,this.doctorPhone,this.acceptedFlag});


  Map<String, dynamic> toMap(){
    return{

      'startAt':startAt,
      'finishedAt':finishedAt,
      'patientName':patientName,
      'patientAddress':patientAddress,
      'patientPhone':patientPhone,
      'doctorName':doctorName,
      'doctorAddress':doctorAddress,
      'doctorPhone':doctorPhone,
      'acceptedFlag':acceptedFlag,

    };
  }

  static Request fromMap(Map<String, dynamic> map){
    return Request(
        startAt:map['startAt'],
      finishedAt:map['finishedAt'],
      patientName:map['patientName'],
      patientAddress:map['patientAddress'],
      patientPhone:map['patientPhone'],
      doctorName:map['doctorName'],
      doctorAddress:map['doctorAddress'],
      doctorPhone:map['doctorPhone'],
      acceptedFlag:map['acceptedFlag'],
    );
  }
}