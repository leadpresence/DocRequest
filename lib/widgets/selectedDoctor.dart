import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/locator.dart';
import 'package:mobiledoc/models/doctorModel.dart';

class SelectedDoctor extends StatelessWidget {
  String lastName;
  String role;
  String address;
  bool isAvailable;
  String passportUrl;
  String pricePerMin;

  SelectedDoctor({
    this.lastName,
    this.role,
    this.address,
    this.isAvailable,
    this.passportUrl,
    this.pricePerMin,
  });


  @override
  Widget build(BuildContext context) {
    final RoutingService _navigationService = locator.get<RoutingService>();

    return
      Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(
              flex: 10,
              child: ListTile(

                  title: Text(
                    "Dr. "+this.lastName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16,color: Colors.indigo),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                          this.role,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12,),
                        )
                      ],),  Row(children: <Widget>[
                        Icon(CupertinoIcons.location,size: 14,color: Colors.indigo,),SizedBox(width: 3,),
                        Text(
                          this.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        )
                      ],)
                    ],
                  ),
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: this.isAvailable? Colors.greenAccent:Colors.redAccent,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      backgroundImage: NetworkImage(this.passportUrl),
                    ),
                  ),
                  trailing: Container(
                    width: 60,

                    child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
////
//                        Container(
//                          width: 50,
//                          padding: EdgeInsets.all(0.1),
//                          decoration: BoxDecoration(
//                            color: Colors.grey[100],
//                            border: Border.all(
//                                color: Colors.grey[400],
//
//                                width: 0.5
//                            ),
//                            borderRadius: BorderRadius.all(
//                                Radius.circular(5.0) //
//                            ),
//                          ),
//                          child: Wrap(children: <Widget>[
//
//                            Icon(CupertinoIcons.phone,size: 15,color: Colors.black,
//
//                          ),
//
//                            SizedBox(width: 5,),
//                            Text("Call",style: TextStyle(fontSize: 12,color: Colors.grey[400],
//                          ),
//                          )],),
//                        ),
//                        SizedBox(height: 25,),
                        Text(
                          '#'+this.pricePerMin.toString()+'/min',
//                        doctor.pricePerMin,
                          style: TextStyle(fontSize: 12),
                        ),


                      ],),
                  ),
                  onTap:(){
//                    _navigationService.navigateTo(MDservicesRoute,arguments: {doctor.lastName,doctor.pricePerMin});
                  }
//                  onTapGesture,
              )
          )
        ]),
        SizedBox(height: 4,),
        Divider(
          endIndent: 12.0,
          indent: 12.0,
          height: 0,
        ),


      ])
    ;
  }
}
