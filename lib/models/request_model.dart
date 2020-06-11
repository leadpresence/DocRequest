import 'package:cloud_firestore/cloud_firestore.dart';
class Request{
  String id;
  var startAt;
  var finishedAt;
  String patientName;
  String patientAddress;
  String patientPhone;
  String patientNote;
  List<String> tokens;
  String doctorName;
  String doctorAddress;
  String doctorPhone;
  int acceptedFlag=0;

  Request({this.id,this.startAt,this.finishedAt,
  this.patientName,this.patientAddress,
  this.patientPhone,this.patientNote,this.tokens,
  this.doctorName,
  this.doctorAddress,this.doctorPhone,this.acceptedFlag});


  Map<String, dynamic> toMap(){
    return{
      'id':id??'',
      'startAt':startAt,
      'finishedAt':finishedAt,
      'patientName':patientName??'',
      'patientAddress':patientAddress??'',
      'patientPhone':patientPhone??'',
      'patientNote':patientNote??'',
      'tokens':tokens??[''],
      'doctorName':doctorName??'',
      'doctorAddress':doctorAddress??'',
      'doctorPhone':doctorPhone??'',
      'acceptedFlag':acceptedFlag??'',

    };
  }

  static Request fromMap(Map<String, dynamic> map){
    return Request(

      startAt:map['startAt'],
      finishedAt:map['finishedAt'],
      patientName:map['patientName'],
      patientAddress:map['patientAddress'],
      patientNote:map['patientNote'],
      patientPhone:map['patientPhone'],
      doctorName:map['doctorName'],
      doctorAddress:map['doctorAddress'],
      doctorPhone:map['doctorPhone'],
      acceptedFlag:map['acceptedFlag'],
    );
  }
}