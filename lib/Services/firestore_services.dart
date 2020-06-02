import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/locator.dart';
import 'package:mobiledoc/models/doctorModel.dart';
import 'package:mobiledoc/models/hospitalModel.dart';
import 'authentication_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobiledoc/main.dart';

/*TO HANDLE DATA ABOUT USER AND PERFORM NECESSARY CRUD SERVICES ON
* ACCOUNT CREATION OR EDIT*/

enum CollectionState{
  Started,
  Collected,
  AddedToList,
  Failed,
  Error
}

class FirestoreServiceAPI {
  static final Firestore _db=Firestore.instance;

  CollectionReference collectionReference=_db.collection('md_users');

  //hosptal collection instance
  CollectionReference hospitalCollectionReference=_db.collection('md_hospitals');
  //Doctors collection instance

  CollectionReference doctorsCollectionReference=_db.collection('md_doctors');
  //hospital controller
  final   StreamController <List<Hospital>> _hospitalController =StreamController  <List<Hospital>>.broadcast();
  final   StreamController <List<Doctor>> _doctorController =StreamController  <List<Doctor>>.broadcast();
  final   StreamController<String> collectionState=StreamController.broadcast();



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Future createUser(User user ) async {
    try {
      await collectionReference.document(user.id).setData(user.toMap(),merge: true);
    } catch (e) {
      debugPrint("FirestoreAPI Error in creating createUser:"+e);
      return;
    }
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//get user by user_id
  Future getUserDocumentById(String id) async
  {
    User details;
    try{
    var userData= collectionReference.document(id).get();
    return await userData.then((doc) {
      print(User.fromMap(doc.data));
      return  details=User.fromMap(doc.data);
    });
    }catch(e){
      return e.toString();
    }
  }

  //check with boolean if a user(client) exists in users collection
  checkDocumentById(String id) async
  {
    bool userExist;
    var userData= collectionReference.document(id).get()
        .then((docSnapshot) {
     if (!docSnapshot.exists || docSnapshot==null) {
       return userExist=false;
     } else {
       return userExist=true;
     }
  });

      return userExist;
  }


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> updateUserBankInfo( Map<String, dynamic> data, String id)async {
    await collectionReference.document(id).updateData(data);
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> updateUserHWGInfo(Map<String, dynamic> data , String id) {
    return collectionReference.document(id).updateData(data);
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> updateUserDob(Map data , String id) {
    return collectionReference.document(id).updateData(data) ;
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> updateAgeInfo(Map data , String id) {
    return collectionReference.document(id).updateData(data) ;
  }
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> updateRoleAndBloodGrpInfo(Map data , String id) {
    return collectionReference.document(id).updateData(data) ;
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> updateMyLocation(Map <String,dynamic> data , String id) {
    return collectionReference.document(id).updateData(data) ;
  }
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  //save my own token to firestore

  Future<void> updateMyPushToken(Map <String,dynamic> data , String id) {
    return collectionReference.document(id).updateData(data) ;
  }


  //save the tokens around me in my "docTokensAround" collection
  Future createTokenSubCollection(Map <String,dynamic> data , String id){
     return collectionReference.document(id).collection('docTokensAround')
         .document("REQ"+FieldValue.serverTimestamp().toString()).setData(data) ;

  }

  //to get all doctors documents ,this is ustilized in getting push token
  doctors() async{
    return collectionReference.getDocuments();
  }



  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  //to fetch hospital
  Stream realTimeHospital() {
    hospitalCollectionReference.snapshots().listen((hospitalSnapshot) {
      if (hospitalSnapshot.documents.isNotEmpty) {
        var hospitals = hospitalSnapshot.documents
            .map((snapshot) => Hospital.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.hospitalName != null).toList();

        //Add to the controller
        _hospitalController.add(hospitals);
        addState("hospital colection successful contains :" + hospitals.length.toString());

      }
    });
    return _hospitalController.stream;
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  //to fetch Doctors
Stream realTimeDoctor(){
    doctorsCollectionReference.snapshots().listen((onDoctorData){
      if(onDoctorData.documents.isNotEmpty){
        var doctors=onDoctorData.documents
            .map((snapshot)=>Doctor.fromMap(snapshot.data))
            .where((mappedItem)=>mappedItem.lastName!=null).toList();
        //add to the stream channel
        _doctorController.add(doctors);
        addState("collections of doctor's sucessfull contains :"
            + doctors.length.toString());
      }
    });
    return _doctorController.stream;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Future<void> removeDocument(String id){
    return collectionReference.document(id).delete();
  }


  Future<DocumentReference> addDocument(Map data) {
    return collectionReference.add(data);
  }

  Future<void> updateDocument(Map data , String id) {
    return collectionReference.document(id).updateData(data) ;
  }

  //service to provide a doccument by id
  Future<DocumentSnapshot> getDocumentById(String id) {
    return collectionReference.document(id).get();
  }

  Future updateUser(User user) async {
    try {
      await collectionReference.document(user.email).updateData(user.toMap());
    } catch (e) {
      return e.message;
    }
  }

  Future<QuerySnapshot> getDataCollection() {
    return collectionReference.getDocuments() ;
  }

  //service to provide all documents in a collection
  Stream<QuerySnapshot> streamDataCollection() {
    return collectionReference.snapshots() ;
  }

void addState(String s){
    collectionState.sink.add(s);
    print(s);
}


@override
 void dispose(){

    _hospitalController.close();
    _doctorController.close();
 }
  void closeSink(){
    collectionState.close();
  }

































// Future<void> updateUserProfile(Map data , String id) {
//    return collectionReference.document(id).updateData(data) ;
//}
//  Future<void> updateDocumentBankDetails(User data , String id) {
//    return collectionReference.document(id).updateData(data.toMap()) ;
//  }

//  Future<void> updateDocumentPhysique(Map data , String id) {
//    return collectionReference.document(id).updateData(data) ;
//  }//

//  Future<void> updateUserDob(Map data , String id) {
//    return collectionReference.document(id).updateData(data) ;
//  }
//
//  Future<void> updateDocumentBloodAge(Map data , String id) {
//    return collectionReference.document(id).updateData(data) ;
//  }
  //TODO fetch all documents in mobiledoc collection and search where phone or email is present
  //TODO if true sign in user with without creating an account else create an account

//-----------------------------------------------------

/////CRUD API For Doctors REQUESTS
//
//  //this creates a subsection of requests when submitted
//
//  Future<void> addDocRequest(Map data, String id){
//    return collectionReference.document(id).collection("doctorRequests").add(data);
//  }
////update doctors Request
//
//Future<void> updateDocRequest(Map data , String id,String subDocId){
//  return collectionReference.document(id)
//      .collection("doctorRequests")
//      .document(subDocId)
//      .setData(data);
//
//}
////get Doctors all Requests
//
//
////get Doctors requested by users Id
//
////delete/Remove  doctors Request

  //demo
//------------------------------Direct calls------------------------------------

//  Future updateUserWithNumber([num mobileNumber, String userEmail,created_at]) async {
//    await collectionReference.document(uIdPath.toString()).setData({
//
//      "phone": mobileNumber,
//      "email": userEmail,
//      "created_at":created_at
//    });
//  }
//
//  Future updateUserProfile([String _fname,String _lname,String _phone,String _email,String _address,])async{
//    await collectionReference.document(uIdPath).updateData({
//
//      "firstName":_fname,
//      "lastname":_lname,
//      "phone":_phone,
//      "address":_email ,
//      "email":_address
//
//    });
//
//  }

//
//  Future updateUserBankInfo([String _bankName,String _accountName,String _accountNumber, ]) async {
//    await collectionReference.document(_authenticationService.user.email).updateData({
//
//      "bankName": _bankName,
//      "accountName": _accountName,
//      "accountNumber": _accountNumber
//    });
//  }
//  Future updateUserHWGInfo([String _bankName,String _accountName,String _accountNumber, ]) async {
//    await collectionReference.document(id).updateData({
//
//      "bankName": _bankName,
//      "accountName": _accountName,
//      "accountNumber": _accountNumber
//    });
//  }
//
//  Future<void> updateDocumentPhysique([_height,_weight,_gender]) {
//    return collectionReference.document(id).updateData({
//      "weight":_weight,
//      "height":_height,
//      "gender":_gender,
//    }) ;
//  }
//  Future updateUserDob([_birtday]){
//    return collectionReference.document(id).updateData({
//      "dateOfBirth":_birtday
//
//    }) ;
//    }


  }

