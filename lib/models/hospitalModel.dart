import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  String id;
  String hospitalName;
  String professionName;
  String rating;
  String email;
  String address;
  String phone;
  String role;
  String logo;
  String dateOfEstablishment;
  String bankName;
  String accountNumber;
  String accountName;
  String folioNumuber;
  String passport;
  String practisingDocument;
  String created_at;
  String currentLocation;
  String distanceFrom;


  Hospital(
      {this.id,
        this.hospitalName,
        this.rating,
        this.professionName,
        this.dateOfEstablishment,
        this.logo,
        this.role,
        this.email,
        this.address,
        this.phone,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.passport,
        this.practisingDocument,
        this.folioNumuber,
        this.created_at,
        this.currentLocation,
        this.distanceFrom
      });


  static Hospital fromMap(Map<String, dynamic> map){
    if(map==null)return null;
    return Hospital(
      id :map['id'],
      hospitalName : map['hospitalName'],
      rating : map['rating'],
      professionName : map['professionName'],
      email : map['email'],
      address : map['address'],
      phone : map['phone'],
      role : map['role'],
      dateOfEstablishment : map['dateOfEstablishment'],
      bankName : map['bankName'],
      accountNumber : map['accountNumber'],
      accountName : map['accountName'],
      folioNumuber : map['folioNumuber'],
      passport : map['passport'],
      practisingDocument : map['practisingDocument'],
      currentLocation : map['currentlocation'],
      distanceFrom : map['distanceFrom'],
      created_at : map['created_at'],

    );}

  Map<String, dynamic> toMap() {
    return
      {
        'id': id,
        'hospitalName': hospitalName,
        'rating': rating,
        'professionName': professionName,
        'email': email,
        'address': address,
        'phone': phone,
        'role': role,
        'photo': logo,
        'dateOfEstablishment': dateOfEstablishment,
        'bankName': bankName,
        'accountNumber': accountNumber,
        'accountName': accountName,
        'folioNumuber': folioNumuber,
        'passport': passport,
        'practisingDocument': practisingDocument,
        'currentLocation': currentLocation,
        'distanceFrom': distanceFrom,
        'created_at': created_at,
      };
  }

// convenience method to create a Map from this Word object



}
