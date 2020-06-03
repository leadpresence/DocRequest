import 'package:cloud_firestore/cloud_firestore.dart';

class User {
    String id;
    String firstName;
    String lastName;
    String email;
    String address;
    String phone;
    String role;
    String photo;
    String age;
    String bloodGroup;
    String gender;
    String height;
    String goal;
    String weight;
    String bankName;
    String accountNumber;
    String accountName;
    String folioNumuber;
    String passport;
    String practisingDocument;
    var created_at;
    Map currentLocation;
    String pushToken;


    User(
    {this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.height,
    this.weight,
    this.bloodGroup,
    this.gender,
    this.photo,
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
    this.goal,
      this.created_at,
      this.currentLocation,
      this.pushToken

  });


  static User fromMap(Map<String, dynamic> map){
    return User(
    id :map['id'],
    firstName : map['firstName'],
      lastName : map['lastName'],
      email : map['email'],
      address : map['address'],
      phone : map['phone'],
      role : map['role'],
      age : map['age'],
      bloodGroup : map['bloodGroup'],
      gender : map['gender'],
      height : map['height'],
      goal : map['goal'],
      weight : map['weight'],
      bankName : map['bankName'],
      accountNumber : map['accountNumber'],
      accountName : map['accountName'],
      folioNumuber : map['folioNumuber'],
      passport : map['passport'],
      practisingDocument : map['practisingDocument'],
      currentLocation : map['currentlocation'],
      created_at : map['created_at'],
      pushToken : map['pushToken'],

    );
  }

  Map<String, dynamic> toMap() {
    return
      {
        'id': id ?? '',
        'firstName': firstName ?? '',
        'lastName': lastName ?? '',
        'email': email ?? '',
        'address': address ?? '',
        'phone': phone ?? '',
        'role': role ?? '',
        'photo': photo ?? '',
        'age': age?? '',
        'bloodGroup': bloodGroup ?? '',
        'gender': gender ?? '',
        'height': height ?? '',
        'goal': goal ?? '',
        'weight': weight,
        'bankName': bankName ?? '',
        'accountNumber': accountNumber ?? '',
        'accountName': accountName ?? '',
        'folioNumuber': folioNumuber ?? '',
        'passport': passport ?? '',
        'practisingDocument': practisingDocument ?? '',
        'currentLocation': currentLocation,
        'created_at': created_at ??'',
        'pushToken': pushToken
      };
  }

    // convenience method to create a Map from this Word object



}
