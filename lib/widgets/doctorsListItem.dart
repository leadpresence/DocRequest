import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/locator.dart';
import 'package:mobiledoc/models/doctorModel.dart';

class DoctorListItem extends StatelessWidget {
 Doctor doctor;
// String lastName;
// String passportUrl;
// String pricePerMin;
// String address;


 DoctorListItem({
   this.doctor
//this.lastName,this.address,this.passportUrl,this.pricePerMin,
//this.doctor
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
//                  this.lastName,
                  "Dr. "+doctor.lastName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16,color: Colors.indigo),
                ),
                subtitle: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Flexible(
                          child: Text(
                          doctor.role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12,),
                      ))
                    ],),  Row(children: <Widget>[
                      Icon(CupertinoIcons.location,size: 14,color: Colors.indigo,),SizedBox(width: 3,),
                      Flexible(
                        child: Text(
                          doctor.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                        ),
                      )
                    ],)
                  ],
                ),
                leading:
                CircleAvatar(
                  radius: 22,
                  backgroundColor: doctor.isAvailable?Colors.greenAccent:Colors.red,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundImage: NetworkImage(
                        doctor.passportUrl??"https://www.rosemaryhomes.com/wp-content/uploads/avatar-placeholder-generic-1-300x300.jpg"
//                    this.passportUrl
                    ),

                  ),
                ),
                trailing: Container(
                  width: 60,

                  child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//
                      Container(
                        width: 50,
                        padding: EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(
                              color: Colors.grey[400],

                              width: 0.5
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0) //
                          ),
                        ),
                        child: Wrap(children: <Widget>[   Icon(CupertinoIcons.phone,size: 15,color: Colors.black,

                        ),SizedBox(width: 5,),Text("Call",style: TextStyle(fontSize: 12,color: Colors.grey[400],
                        ),
                        )],),
                      ),
                      SizedBox(height: 25,),
                      Text(
                        '#'+doctor.pricePerMin.toString()+'/min',
//                        '#'+this.pricePerMin+'/min',
//                        doctor.pricePerMin,
                        style: TextStyle(fontSize: 12),
                      ),


                    ],),
                ),
//                onTap:()=>doctor.isAvailable?
//                null
//                :  Fluttertoast.showToast(msg: "This Doctor is presensently unavailable",
//                toastLength: Toast.LENGTH_LONG)
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
