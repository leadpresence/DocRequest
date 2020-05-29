import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String id;
  String firstName;
  String lastName;
  String email;
  String address;
  String phone;
  String role;
  String professionalTitle;
  String logo;
  String age;
  String bankName;
  String accountNumber;
  String accountName;
  String folioNumuber;
  String passportUrl;
  String practisingDocumentUrl;
  Timestamp created_at;
  bool isAvailable;
  String currentLocation;
  String pricePerMin;
  String rating;


  Doctor(
      {this.id,
        this.firstName,
        this.lastName,
        this.age,
        this.logo,
        this.role,
        this.professionalTitle,
        this.email,
        this.address,
        this.phone,
        this.bankName,
        this.accountNumber,
        this.accountName,
        this.passportUrl,
        this.practisingDocumentUrl,
        this.folioNumuber,
        this.created_at,
        this.isAvailable,
        this.currentLocation,
        this.pricePerMin,
        this.rating
      });


  static Doctor fromMap(Map<String, dynamic> map){
    if (map==null) return null;
    return Doctor(
      id :map['id'],
      firstName : map[' firstName'],
      lastName : map['lastName'],
      email : map['email'],
      address : map['address'],
      phone : map['phone'],
      role : map['role'],
      age : map['age'],
      bankName : map['bankName'],
      accountNumber : map['accountNumber'],
      accountName : map['accountName'],
      folioNumuber : map['folioNumuber'],
      passportUrl : map['passportUrl'],
      practisingDocumentUrl : map['practisingDocumentUrl'],
      currentLocation : map['currentlocation'],
      created_at : map['created_at'],
      isAvailable : map['isAvailable'],
      pricePerMin : map['pricePerMin'],
      rating : map['rating'],

    );}

  Map<String, dynamic> toMap() {
    return
      {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'address': address,
        'phone': phone,
        'role': role,
        'role': professionalTitle,
        'professionalTitle': professionalTitle,
        'photo': logo,
        'age': age,
        'bankName': bankName,
        'accountNumber': accountNumber,
        'accountName': accountName,
        'folioNumuber': folioNumuber,
        'passportUrl': passportUrl,
        'practisingDocumentUrl': practisingDocumentUrl,
        'currentLocation': currentLocation,
        'created_at': created_at,
        'isAvailable': isAvailable,
        'pricePerMin': pricePerMin,
        'rating': rating,

      };
  }
  contains(String name){
    Doctor feature;
//    bool contains(Pattern name, [int startIndex = 0]);
if (feature.role.toString().contains(name.substring(0,7))||
    feature.address.toString().contains(name.substring(0,7))||
    feature.lastName.toString().contains(name.substring(0,7))||
    feature.firstName.toString().contains(name.substring(0,7))||
    feature.pricePerMin.toString().contains(name.substring(0,7))
)
  return true;
  }

}

