import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:location/location.dart';
import 'dart:async';
//import 'dart:convert' as convert;

///constant used as default when user comes on the doctor request screen
const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(6.614243, 3.358446);
const LatLng DEST_LOCATION = LatLng(6.436042, 3.451725);

class RequestDoctor extends StatefulWidget {
  @override
  _RequestDoctorState createState() => _RequestDoctorState();
}

class _RequestDoctorState extends State<RequestDoctor> {

///boolean to  hold the state of the cupertino dailog
  bool _dismisAlert = false;


  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints= PolylinePoints();
  String googleAPIKey = "AIzaSyA3whKRHle7Fv6bk4mntyUY6f70CPIFHY8";


//  final Set<Polyline> _gpolylines= {};
//  List <LatLng> routeCords;
//  GoogleMapPolyline _googleMapPolyline=new GoogleMapPolyline(apiKey:'AIzaSyA3whKRHle7Fv6bk4mntyUY6f70CPIFHY8');
//  getSomePoints()async{
//    routeCords=await _googleMapPolyline.getCoordinatesWithLocation
//      (origin: SOURCE_LOCATION, destination: DEST_LOCATION, mode:RouteMode.driving );
//  }





// for my custom marker pins
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

// the user's initial location and current location
// as it moves
  LocationData currentLocation;


// a reference to the destination location
  LocationData destinationLocation;

// wrapper around the location API
  Location location;

/*To initialize current location of the user and hold
 location data longLat to keep the state of user
  location and update in real time
* */
  void initState() {
    super.initState();
    // set custom marker pins
    setSourceAndDestinationIcons();
//    getSomePoints();
///we bind the Cupertino modal to  the screen to welcome the user as they finish registration

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<void>(
        context: context,
        barrierDismissible: _dismisAlert, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              "Thank  you",
              style: _style,
              textAlign: TextAlign.left,
            ),
            content: Text(
              'Thank you for registering with mobiledoc.     \n[Doctors]Please complete your registration and be activated by visiting our office.',
              softWrap: true,
              style: _smallStyle,
              textAlign: TextAlign.left,
            ),
            actions: <Widget>[
              //               CupertinoDialogAction(
              //                 child: Text('Don\'t Allow'),
              //                 onPressed: () {
              //                   Navigator.of(context).pop();
              //                 },
              //               ),
              CupertinoDialogAction(
                child: Text('Okay'),
                onPressed: () {
                  _dismisAlert = true;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });

///Map & Location Instances
///all initialization for user location is done here

    //*this creates an instance of Location
//    location = new Location();
//     polylinePoints = PolylinePoints();

// subscribe to changes in the user's location
// by "listening" to the location's onLocationChanged event
//    location.onLocationChanged.listen((LocationData cLoc) {
// cLoc contains the lat and long of the
// current user's position in real time, so we're holding on to it
//      currentLocation = cLoc;
          updatePinOnMap();
//    });

// set the initial location
//    setInitialLocation();

  //**this is don for performance changes on current location is done
  //** for every 500meters, and 10million seconds
//       location.changeSettings(distanceFilter: 10.0,interval: 10000000);

  }//<!--inistate-->

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/source-pin.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/source-pin.png');
  }
//      void setInitialLocation() async {
// set the initial location by pulling the user's
// current location from the location's getLocation()
//             currentLocation = await location.getLocation();

    // hard-coded destination for this example
    //TODO get user location stored on firebase and serialize to a map here
//    destinationLocation = LocationData.fromMap({
//      "latitude": DEST_LOCATION.latitude,
//      "longitude": DEST_LOCATION.longitude
//    });
//  }
  //Create circles
//  Circle createCircle(Color color, LatLng _position) {
//    return Circle(
//        circleId: CircleId(_position.toString()),
//        fillColor: color,
//        strokeColor: color.withOpacity(0.4),
//        center: _position,
//        strokeWidth: 75,
//        radius: 32.0,
//        visible: true);
//  }


    @override
    Widget build(BuildContext context) {
//*camera position is required to set the view of of the map with LatLong values
//*set default location to lekki lagos ,otherwise set currrent location to user's
//*current location

      CameraPosition initialCameraPosition = CameraPosition(
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING,
          target: SOURCE_LOCATION
      );
//      if (currentLocation != null) {
//            initialCameraPosition = CameraPosition(
//            target: LatLng(currentLocation.latitude,
//                             currentLocation.longitude),
//            zoom: CAMERA_ZOOM,
//            tilt: CAMERA_TILT,
//            bearing: CAMERA_BEARING
//        );
//      }

      return SafeArea(
        child: Scaffold(

///* We place the screen elements on a stack according to how w want them to appear on the View
            body: Stack(
              children: <Widget>[

///Google Maps This Show user specific location when all is set and fine
                GoogleMap(
                    myLocationEnabled: true,
                    compassEnabled: true,
                    tiltGesturesEnabled: false,
                    markers: _markers,
                    polylines: _polylines,
                    mapType: MapType.normal,
//                    trafficEnabled: true,
                    initialCameraPosition: initialCameraPosition,
                    onMapCreated: onMapCreated
                    ),

                Container(
                  padding: EdgeInsets.only(bottom: 490),
                  alignment: Alignment.bottomCenter,
                  child: DoctorSwitch(),
                ),
              ],
            )
        ),
      );
///widget scaffold & safeArea end here


    }///closes widget
  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setMapPins();
    setPolylines();

  }

  ///*Show pins when all is set for the Map----->
  void setMapPins() {
//    // get a LatLng for the source location
//    // from the LocationData currentLocation object
//    var pinPosition = LatLng(currentLocation.latitude,
//        currentLocation.longitude);
//    // get a LatLng out of the LocationData object
//    var destPosition = LatLng(destinationLocation.latitude,
//        destinationLocation.longitude);
//    // add the initial source location pin
//    _markers.add(Marker(
//        markerId: MarkerId('sourcePin'),
//        position: pinPosition,
//        icon: sourceIcon
//    ));
//    // destination pin
//    _markers.add(Marker(
//        markerId: MarkerId('destPin'),
//        position: destPosition,
//        icon: destinationIcon
//    ));

  _markers.add(Marker(
    markerId: MarkerId('sourcePin'),
    position: SOURCE_LOCATION,
    icon: sourceIcon

  ));
  _markers.add(Marker(
    markerId: MarkerId('destinationPin'),
    position: DEST_LOCATION,
    icon: destinationIcon
  ));
  }

//
  setPolylines() async {
    List<PointLatLng> result = await
    polylinePoints?.getRouteBetweenCoordinates(
        googleAPIKey,
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude,
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude);
    if(result.isNotEmpty){
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point){
        polylineCoordinates.add(
            LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
  //To  create a Polyline instance with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Colors.black,
          points: polylineCoordinates
      );

  // To add the constructed polyline as a set of points to the MaP
      _polylines.add(polyline);
      print("polylin :${_polylines.toString()}");

    });
  }
///Update the map Algorithm------------------------------>
  void updatePinOnMap() async {
        print("Am here"+ currentLocation.toString());
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude,
          currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    setState(() {
      // updated position
      var pinPosition = LatLng(currentLocation.latitude,
          currentLocation.longitude);

      // and add it again at the updated location
      _markers.removeWhere(
              (m) => m.markerId.value == 'sourcePin');
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: pinPosition, // updated position
          icon: sourceIcon
      ));
    });
  }


  //***show doctors listing on view----------------->
  Widget _doctorsListing(){
    ///this is called when a client request listings for doctors
    ///it comes up as a bottom sheet container with list of Doctors nearby
    return Container(
      child: BottomSheet(onClosing: null, builder: null),
    );
  }

///Class scope variables of text styling

    static final _style = TextStyle(fontWeight: FontWeight.bold, fontSize: 22);
    static final _smallStyle = TextStyle(
        fontWeight: FontWeight.normal, fontSize: 14, color: Colors.grey[800]);
  }
  //TODO set the CORRECT GoogleMap API FOR DISTANCE
  //TODO CREATE A DOCUMENT -REQUESTS ON FIREBASE RELATING TO THE ID ON EACH USER
  //TODO REQUEST WILL HAVE FIELDS MOBILE NUMBER,LONGITUDE ,LATITUDE ,DATATIME,RECIEVER_NUMBER SO THIS

