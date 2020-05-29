import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/widgets/CustomButton.dart';

import 'package:stacked/stacked.dart';
import 'package:mobiledoc/ui/viewmodels/role_bloodGrpVm.dart';


class RoleAndBloodGrp extends StatefulWidget {
  @override
  _RoleAndBloodGrpState createState() => _RoleAndBloodGrpState();
}

class _RoleAndBloodGrpState extends State<RoleAndBloodGrp> {
  String _role;
  String _bloodGrp;
  Color color;
  Color btnColor=Colors.grey;
  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<RoleAndBloodGrpVM>.reactive(
        viewModelBuilder: ()=>RoleAndBloodGrpVM(),
        onModelReady: (model)=>model.initialise(),
        builder: (context,model,child)=>Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(
                "Profile Details",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 14,
                ),
                onPressed: () {
//                  if (Navigator.of(context).canPop()) {
//                    Navigator.pushNamed(context, BankDetailsRoute);
//                  }
                },
              ),
            ),

            ///*Body Section holds everything eithing the scaffold consisting
            ///**Weight Widget  *Height widget *Gender Widget *custom widget
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, right: 4, left: 4, bottom: 4),
                  child: Column(
                    children: <Widget>[
                      new Wrap(
                        alignment: WrapAlignment.center,
                        children: <Widget>[
                          Text(
                            'Role',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),

                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            'Blood Group',
                            style: TextStyle(fontSize: 18),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 15, left: 45, right: 45),
                        constraints: BoxConstraints(maxWidth: 320, maxHeight: 320),
                        width: 600,
                        height: 600,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              // has the effect of softening the shadow
                              spreadRadius: 0.0,
                              // has the effect of extending the shadow
                              offset: Offset(
                                2.0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ),
                            )
                          ],
                        ),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            role(),
                            SizedBox(
                              width: 25,
                            ),
                            blood(),
                            SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),


                      CustomButton(
                        color: btnColor,btnTitle: "Finish",
                        buttonPressed: (){
                          btnColor==Colors.grey?
                          Fluttertoast.showToast(msg: "Avoid using invalid dates",toastLength: Toast.LENGTH_SHORT)
                        : model.updateRoleAndBloodGrp(_role, _bloodGrp);

                          print("Role: " + _role + ",Bloodgrp: " + _bloodGrp);
                      },),
                    ],
                  ),
                ),
              ),
            )),


      );

  }




  Widget blood(){
    List<String> bloodGroups=['A+','A-','AB+','AB-','B+','B-','O+','O-','other'];
    int _selectedBloodGrp;
    return Container(
        constraints: BoxConstraints(maxWidth: 50, maxHeight: 250),
    child: CupertinoPicker(
    itemExtent: 60.0,
    backgroundColor: CupertinoColors.white,
      onSelectedItemChanged: (index) {
        setState(() {
          btnColor=Colors.blue;
          _selectedBloodGrp = index ;
          switch (_selectedBloodGrp) {
            case 0:
              {
                _bloodGrp = "A+";
              }
              break;
            case 1:
              {
                _bloodGrp = "A-";
              }
              break;
            case 2:
              {
                _bloodGrp = "AB+";
              }
              break;
            case 3:
              {
                _bloodGrp = "AB-";
              }
              break;
            case 4:
              {
                _bloodGrp = "B+";
              }
              break;
            case 5:
              {
                _bloodGrp = "B-";
              }
              break;
            case 6:
              {
                _bloodGrp = "O+";
              }
              break;
            case 7:
              {
                _bloodGrp = "O-";
              }
              break;

          }
          color = Colors.blue;
          print("blood group: ${_bloodGrp}");
        });
      } ,
        children: new List<Widget>.generate(bloodGroups.length, (index) {
      return new Center(
        child: Text(
          bloodGroups[index].toString(),
          style: TextStyle(fontSize: 16.0, color: color),
        ),
      );
    }),

    )

    );


  }
  Widget role(){

    List<String> roles=['Client' /**,'Doctor','Nurse'*/,'Other'];
    int _selectedRole;
    return Container(
        constraints: BoxConstraints(maxWidth: 50, maxHeight: 250),
        child: CupertinoPicker(
          itemExtent: 60.0,
          backgroundColor: CupertinoColors.white,
          onSelectedItemChanged: (index) {
            setState(() {
              btnColor=Colors.blue;

              _selectedRole = index ;
              switch (_selectedRole) {
                case 0:
                  {
                    _role = "Client";
                  }
                  break;
               /** case 1:
                  {
                    _role = "Doctor";
                  }
                  break;
                case 2:
                  {
                    _role = "Nurse";
                  }
                  break;*/
                case 1:
                  {
                    _role = "Other";
                  }
                  break;
              }
              color = Colors.blue;
              print("Role : ${_role}");
            });
          } ,
          children: new List<Widget>.generate(roles.length, (index) {
            return new Center(
              child: Text(
                roles[index].toString(),
                style: TextStyle(fontSize: 16.0, color: color),
              ),
            );
          }),

        )

    );

  }
}
