import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:core';

class DoctorSwitch extends StatefulWidget {




  @override
  _DoctorSwitchState createState() => _DoctorSwitchState();
}

class _DoctorSwitchState extends
State<DoctorSwitch> with
    SingleTickerProviderStateMixin{

//  Future _getUserLocation() async {
//    final location = await Geolocator()
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//    return location;
//  }


  ///GET USER CURRENT LOCATION
  static CameraPosition _kLagos;


  bool isChecked = false;
  Duration _duration = Duration(milliseconds: 370);
  Animation<Alignment> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: _duration
    );

    _animation = AlignmentTween(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight
    ).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child){
        return Container(
          width: 100,
          height: 40,
          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
          decoration: BoxDecoration(
            color: isChecked ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
//              boxShadow: [
//                BoxShadow(
//                    color: isChecked ? Colors.blue : Colors.grey[300],
//                    blurRadius: 4,
//                    offset: Offset(0, 8)
//                )
//              ]
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: _animation.value,
                child: GestureDetector(
                    onTap: (){
                      setState(() {
                        if(_animationController.isCompleted){
                          _animationController.reverse();
                        }else{
                          _animationController.forward();

                          print('he');

//                          _getUserLocation().then((val) {
//                            setState(() {
//                              _kLagos = CameraPosition(
//                                bearing: 192.8334901395799,
//                                target: LatLng(val.latitude, val.longitude),
//                                zoom: 11.151926040649414,
//                              );
//                            });
//                          }).catchError((e) {
//                            //if there is an error setDefault
//                            print(e);
//                          });
                        }

                        isChecked = !isChecked;
                      });
                    },
                    child: Stack(children: <Widget>[
                      //TODO make text animate with image
//                  Text("Online"),
                      Container(
                        padding: EdgeInsets.all(25),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("assets/images/doc_icon.png")
                            )
                        ),
                      ),
                    ],)
                ),
              )
            ],
          ),
        );
      },
    );
  }
}