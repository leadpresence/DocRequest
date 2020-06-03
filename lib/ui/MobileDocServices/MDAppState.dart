import 'dart:async';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobiledoc/Services/authentication_services.dart';

import 'package:mobiledoc/Services/firestore_services.dart';
import 'package:mobiledoc/models/UserModel.dart';
import 'package:mobiledoc/models/doctorModel.dart';
import 'package:mobiledoc/ui/viewmodels/base_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mobiledoc/locator.dart';
import './MDrequests.dart';

class MDAppState extends BaseModel {

  FirestoreServiceAPI _firestoreServiceAPI = locator<FirestoreServiceAPI>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String doctorsLocationField = 'currentLocation';
  List <String> _tokenDoctorsAround;
  List <String> get tokenDoctorsAround=>_tokenDoctorsAround;
  List <String> _message;
  List <String> get message=>_message;


  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  final Set<Marker> _markers = {};
  final Set<Marker> _docMarkers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController docSearchController = TextEditingController();
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;
  // for my custom marker pins
  BitmapDescriptor _sourceIcon;
  BitmapDescriptor _destinationIcon;
  // for my custom marker pins
  BitmapDescriptor get sourceIcon => _sourceIcon;
  BitmapDescriptor get destinationIcon => _destinationIcon;
  Position _position = Position();
  Position get position => _position;
  GeoFirePoint _geoFirePoint;
  GeoFirePoint get geoFirePoint=> _geoFirePoint;
  User _user = currentUser;
  //this holds the the doctors called from firebase
  List<Doctor> _doctors;
  List<Doctor> get doctors => _doctors;

  //this holds suggestions as they are requested by a clent
  List<Doctor> _doctorSuggestion;
  List<Doctor> get doctorSuggestion => _doctorSuggestion;

//  StreamSubscription _doctorsStream;
//  StreamSubscription get doctorsStream => _doctorsStream;
  Stream<List<DocumentSnapshot>> stream;
  var radius = BehaviorSubject<double>.seeded(1.0);
  double _distance;
  double get distance => _distance;
  //doctors around user stream controller

//final StreamController <Stream<dynamic>> _doctreamCtrl=
//    StreamController  <Stream<dynamic>>.broadcast();

  MDAppState() {
    _getUserLocation();
    _loadingInitialPosition();
    setSourceAndDestinationIcons();
  }
// ! TO GET THE USERS LOCATION
  void _getUserLocation() async {
    print("GET USER METHOD RUNNING >>>>>>>");
    _position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    print(
        "the latitude is: ${position.latitude} and the longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");
//    updateMyLocation(position.latitude, position.longitude);
    locationController.text =
        placemark[0].name + " " + placemark[0].thoroughfare;
    //center for surrounding doctors
    _geoFirePoint = GeoFirePoint(position.latitude, position.longitude);
    print("GeoFirePointData "+
        geoFirePoint.data['geopoint'].latitude.toString()+" "+"\n"+
        geoFirePoint.data['geopoint'].longitude.toString()+" "+
        geoFirePoint.data['geohash'].toString());
    getDoctorsAroundMe();
    radius.add(200.0);
    notifyListeners();
  }

//  setMessage(List<String> m){
//    String msg;
//    m.forEach((_){
//      message.add(m);
//    });
//  }

  //To update client loaction to firestore
  Future setLocation() async {
    try {
      print("GeoFire Location >> "+geoFirePoint.data);

      await _firestoreServiceAPI.updateMyLocation(
              {'currentLocation': {_geoFirePoint.data}},
              _authenticationService.currentUser.id);
    } catch (e) {
      debugPrint("FirestoreAPI Error in setLocation: "+ e);
      return e;
    }
  }

  //to fetch doctors around this user
  void getDoctorsAroundMe() async {
    // Create a geoFirePoint
    Geoflutterfire _geoFirePoint = Geoflutterfire();
    // Create a geoFirePoint center point
    GeoFirePoint center = _geoFirePoint.point(
        latitude: position.latitude, longitude: position.longitude);
    // get the collection reference or query
    stream = radius.switchMap((fun) {
      var collectionReference = _firestoreServiceAPI.doctorsCollectionReference;
      return _geoFirePoint
          .collection(collectionRef: collectionReference)
          .within(
              center: center,
              radius: fun,
              field: 'currentLocation',
              strictMode: true);
    });
  }

  //TO PLACE MARKERS ON THE MAP SHOWING DOCTORS LOCATION
  void _getDoctorsAround(List<DocumentSnapshot> documentList) {
    print("marker document List  ${documentList.length}");
    documentList.forEach((DocumentSnapshot document) {
//      GeoPoint pos = document.data['currentLocation']['geopoint'];
      double lat = document.data['currentLocation']['geopoint'].latitude;
      double long = document.data['currentLocation']['geopoint'].longitude;
//      double distance = document.data['distance'];

  //Push the individual token into this List and send
      String _token= document.data['pushToken'];
        _tokenDoctorsAround.add(_token);
      _markers.add(Marker(
          markerId: MarkerId(lat.toString()),
//        position: LatLng(pos.latitude, pos.longitude),
          position: LatLng(lat, long),
          icon: _sourceIcon,
          infoWindow: InfoWindow(
          title: 'Magic Marker', snippet: 'few kilometers from doctor')));
    });
    notifyListeners();
  }


  //To send notification to all available doctors within a radius
  //locations from _getCloseDoctors
  void _dispatchDoctors() async {
    //TODO handle sending push notifications

  }

//To handle the reciept of a  request
  void _handleRequestAcceptance() async {
    //TODO create a requisition on fire for this user
    //TODO  show polylines on the map when accepted see sendRequest()
  }

  // TO CREATE POLYLINE ROUTES on AMP
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 3,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  ///this add makers on the given map
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: sourceIcon));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  /// send request to find patients location
  ///this is called on clicking go after entering address

  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation);
    String route = await _googleMapsServices.getRouteCoordinates(
        _initialPosition, destination);
    createRoute(route);
    notifyListeners();
  }

  ///To animate and move camera position as it moves
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  ///To place the component map on the view
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    stream.listen((List<DocumentSnapshot> documentList) {
      if(documentList!=null){
        _getDoctorsAround(documentList);

      }
    });

    notifyListeners();
  }

//  LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }

  void setSourceAndDestinationIcons() async {
    _sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/source-pin.png');

    _destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/clients_home_pin.png');
    notifyListeners();
  }

  //TODO fetch all Doctors from the firestore API

  void getDoctors() {
    setBusy(true);
    _firestoreServiceAPI.realTimeDoctor().listen((doctorData) {
      List<Doctor> updateDoctors = doctorData;
      if (updateDoctors != null && updateDoctors.length > 0) {
        _doctors = updateDoctors;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  //TODO get doctors within 50km radius with geoflutture fire

//~To get doctors     with geo firestore
  Future<void> getHospitalsAdountMe() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    radius.close();
  }

  getDistance(double clientLatitude, double clientLongitude,
      double vendorsLatitude, double vendorsLongitude) {
    const R = 6371e3; // metres
    double latA = clientLatitude * math.pi / 180; // φ, λ in radians
    double latB = vendorsLatitude * math.pi / 180;
    double latSum1 = (clientLatitude - vendorsLatitude) * math.pi / 180;
    double longSum2 = (clientLongitude - vendorsLongitude) * math.pi / 180;

    double a = math.sin(latSum1 / 2) * math.sin(latSum1 / 2) +
        math.cos(latA) *
            math.cos(latB) *
            math.sin(longSum2 / 2) *
            math.sin(longSum2 / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a)
    );

    double d = (R * c); // in metres
    double distanceKilometers = d / 1000.round(); // in metres

    _distance = distanceKilometers;
    notifyListeners();
  }
}
//destinationController changed to docSearchController
