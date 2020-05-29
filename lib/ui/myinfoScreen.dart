import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiledoc/ui/viewmodels/myInfoVM.dart';

import 'package:mobiledoc/widgets_imports.dart';

import 'package:stacked/stacked.dart';

class Profile extends StatefulWidget {
//  String userFullName=this.firstname+" "+lastName;

 String firstName;
 String lastName;
 String  age;
 String gender;
 String  goal;
 String height;
 String weight;

  Profile({
    this.age,this.firstName,this.lastName,
    this.gender,this.height,this.weight,this.goal});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  @override
  Widget build(BuildContext context) {
    return
        ViewModelBuilder<MyInfoVm>.reactive(
            viewModelBuilder: ()=>MyInfoVm(),
          onModelReady:(model)=>model.getUserInfo(),
          builder: (context,model ,child)=>

              SafeArea(
            child:
            Scaffold(
              resizeToAvoidBottomPadding: false,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(
//                  "My Info",
                  model.userDetails.lastName,
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, DashboardRoute);
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                ),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 2.0),
                    child: FlatButton(
                      color: Colors.white,
                      onPressed: (){
                        Navigator.pushNamed(context, CompleteProfileRoute);
                      },
                      child:
                      Icon(FontAwesomeIcons.edit,size: 20,color: Colors.black,),
                    ),
                  )
                ],
              ),
              body:
              SingleChildScrollView(child:       Container(
                  child: Column(children: <Widget>[
                    Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 60.0, left: 5, right: 5),
                          child: Container(
                            //replace this Container with your Card
//              color: Colors.red,
                            height: 300.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                border: new Border.all(
                                    color: Colors.grey, width: 0.1, style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            //Profile content------------->
                            child: Column(
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      EdgeInsets.only(top: 45, left: 120, right: 100),
                                      //TODO Username: "populate dynamically first name and Last name
                                      child: Text(

                                        model.userDetails.firstName==null?"--": model.userDetails.firstName,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ],
                                ),

                                ///Age , Blood group, Gender
                                SizedBox(
                                  height: 15,
                                ),
                                Wrap(

                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child: Column(

                                            children: <Widget>[

                                              Row(children: <Widget>[
                                                Text("Age")
                                              ],),
                                              SizedBox(height: 1,),
                                              Row(children: <Widget>[
                                                Text(
                                                    model.userDetails.age==null?"--":model.userDetails.age

                                                )

                                              ],)
                                            ],
//                                            crossAxisAlignment: CrossAxisAlignment.baseline
                                        ),
                                        height: _boxHSize,
                                        width: _boxWSize,
                                        decoration: _box),
                                    Container(
                                      child: Column(

                                          children: <Widget>[

                                            Row(children: <Widget>[
                                              Text("Blood Group")
                                            ],),
                                            SizedBox(height: 1,),
                                            Row(children: <Widget>[
                                              Text(
                                                model.userDetails.bloodGroup==null?"--":model.userDetails.bloodGroup

                                              )
                                            ],)
                                          ],
//                                          crossAxisAlignment: CrossAxisAlignment.baseline
                                      ),
                                      height: _boxHSize,
                                      width: _boxWSize,
                                      decoration: _box,
                                    ),
                                    Container(
                                      child:  Column(

                                          children: <Widget>[

                                            Row(children: <Widget>[
                                              Text("Gender")
                                            ],),
                                            Row(children: <Widget>[
                                              Text(
                                                 model.userDetails.gender==null?"--":model.userDetails.gender
                                              )
                                            ],)
                                          ],
//                                          crossAxisAlignment: CrossAxisAlignment.baseline
                                      ),
                                      height: _boxHSize,
                                      width: _boxWSize,
                                      decoration: _box,
                                    )
                                  ],
                                ),

                                ///Height, weight , Goal
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        child:  Column(

                                            children: <Widget>[

                                              Row(children: <Widget>[
                                                Text("Height")
                                              ],),
                                              SizedBox(height: 1,),
                                              Row(children: <Widget>[
                                                Text(
                                                    model.userDetails.height==null?"--":model.userDetails.height

                                                )

                                              ],)
                                            ],
//                                            crossAxisAlignment: CrossAxisAlignment.baseline
                                        ),
                                        height: _boxHSize,
                                        width: _boxWSize,
                                        decoration: _box),
                                    Container(
                                      child:  Column(

                                          children: <Widget>[

                                            Row(children: <Widget>[
                                              Text("Weight")
                                            ],),
                                            Row(children: <Widget>[
                                                Text(
                                                    model.userDetails.weight==null?"--":model.userDetails.weight
                                                )
                                            ],)
                                          ],
//                                          crossAxisAlignment: CrossAxisAlignment.baseline
                                      ),
                                      height: _boxHSize,
                                      width: _boxWSize,
                                      decoration: _box,
                                    ),
                                    Container(
                                      child:  Column(

                                          children: <Widget>[

                                            Row(children: <Widget>[
                                              Text("Goal")
                                            ],),
                                            Row(children: <Widget>[

                                            ],)
                                          ],
//                                          crossAxisAlignment: CrossAxisAlignment.baseline
                                      ),
                                      height: _boxHSize,
                                      width: _boxWSize,
                                      decoration: _box,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

// Profile photo positioned on the container

                        Positioned(
                          bottom: 260,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration:
                            ShapeDecoration(shape: CircleBorder(), color: Colors.grey[100]),
                            child: Padding(
                              padding: EdgeInsets.all(2),
                              child: DecoratedBox(
                                decoration: ShapeDecoration(
                                    shape: CircleBorder(),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        NetworkImage(
                                          'http://via.placeholder.com/350x150',
                                        ),

                                    ),

                                    shadows: List<BoxShadow>()),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Doctors report Button
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 280,
                        decoration: BoxDecoration(
                            border: new Border.all(
                                color: Colors.black,
                                width: 0.4,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ReportRoute);
                              print("report page");
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.blur_on,
                                color: Colors.blue,
                                size: 20,
                              ),
                              title: Text(
                                'Request Doctor\'s Report',
                                style: TextStyle(color: Colors.black, fontSize: 11),
                                textAlign: TextAlign.left,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.blue,
                              ),
                            )),
                      ),
                    )
                  ]))
              ),
            ),
          ),

        );
  }

  double _boxHSize = 100;
  double _boxWSize = 100;
  BoxDecoration _box = new BoxDecoration(
    border: new Border.all(
        color: Colors.grey[200], width: 0.4, style: BorderStyle.solid),
//        borderRadius: BorderRadius.all(Radius.circular(5))
  );
}
