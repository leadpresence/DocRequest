import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/locator.dart';
import 'package:mobiledoc/models/hospitalModel.dart';

class HospitalListItem extends StatelessWidget {

final Hospital hospital;

  HospitalListItem({this.hospital
});



  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Expanded(
            flex: 10,
            child: ListTile(

              title: Text(
               hospital.hospitalName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16,color: Colors.indigo),
              ),
              subtitle: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Text(
                      hospital.professionName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12,),
                    )
                  ],),
                  Row(
                    children: <Widget>[
                    Icon(CupertinoIcons.location,size: 14,color: Colors.indigo,),
                      SizedBox(width: 3,),
                    Text(
                      hospital.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 9),
                    )
                  ],)
                ],
              ),
              leading:
              Container(
                height: 50,width:50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  image: DecorationImage(
                      image: hospital.logo==null
                          ? AssetImage("assets/images/default_logo.jpg")
                          : NetworkImage(hospital.logo),
                      fit: BoxFit.cover),

                ),
              ),
              trailing: Container(
                width: 60,

                child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
//
                    Wrap(children: <Widget>[
                      Icon(FontAwesomeIcons.paperPlane,size: 10,color: Colors.black,),
                      SizedBox(width: 3,),
                      Text(hospital.distanceFrom+"km",style: TextStyle(fontSize: 11,color: Colors.grey[400],
                      ),)],
                    ),
                    SizedBox(height: 15,),
                    Wrap(children: <Widget>[
                      Icon(FontAwesomeIcons.star,size: 10,color: Colors.black,),
                      SizedBox(width: 6,),
                      Text(hospital.rating  ,style: TextStyle(fontSize: 11,color: Colors.blueAccent,
                      ),
                      )],
                    ),



                  ],),
              ),
              onTap: () {

              },
            )
        )
      ]),
      Divider(
        endIndent: 12.0,
        indent: 12.0,
        height: 0,
      ),


    ]);
  }
}
