
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
const apiKey = "AIzaSyA3whKRHle7Fv6bk4mntyUY6f70CPIFHY8";
var uuid = Uuid();
String _sessionToken;

class GoogleMapsServices{
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
      String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }


  Future <String> getGooglePlaces(String addressInput)async{
     _sessionToken=uuid.v4();
    String _type='(cities)';
    String url="https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$addressInput&key=$apiKey&type=$_type&sessiontoken=$_sessionToken";
     http.Response response = await http.get(url);
     Map values = jsonDecode(response.body);
     print(response);
     print(values);
    return values['prediction'];

  }
}