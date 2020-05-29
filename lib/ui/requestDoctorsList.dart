import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/ui/MobileDocServices//MDScreen.dart';
import 'package:mobiledoc/ui/viewmodels/requestDoctorsListVM.dart';
import 'package:mobiledoc/widgets/doctorsListItem.dart';
import 'package:mobiledoc/widgets/hospitalListItem.dart';

import 'package:stacked/stacked.dart';

class RequestDoctorsList
extends StatefulWidget {
  @override
  _RequestDoctorsListState createState() => _RequestDoctorsListState();
}

class _RequestDoctorsListState extends State<RequestDoctorsList> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestDoctorListVM>.reactive(
      viewModelBuilder: ()=>RequestDoctorListVM(),
      onModelReady: (model)=>model.getDoctors(),
      builder: (context,model,child)=>
          SafeArea(
            child:

            Scaffold(
                resizeToAvoidBottomPadding: false,
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    "Request Doctor",
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
                ),
                body:

                Padding(
                  padding: EdgeInsets.only(top: 10,
                  ),
                  child:
                  Container(
                      height: double.infinity,
                      child: model.doctors != null ?
                      ListView.builder(
                          itemCount: model.doctors.length,
                          itemBuilder: (context, index)
                          {
                            return
                            GestureDetector(
                               child: DoctorListItem
                                         (
                                    doctor:model.doctors[index],
                                         ),
                              onTap: (){},
                            );

                          }

                      ) :
                      Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Just wait, while  we fetch available doctors..."),
                            SizedBox(height: 8,),
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  Theme
                                      .of(context)
                                      .primaryColor),
                            ),
                          ],
                        )
                      )
                  ),
                )

            ),
          ),
    );
  }


}
