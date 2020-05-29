import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/Services/authentication_services.dart';


class DashBoard extends StatefulWidget {
  _DashBoard createState()=>_DashBoard();

}

 class _DashBoard extends State<DashBoard>{
  AuthenticationService _authenticationService;
  RoutingService _routingService=locator.get<RoutingService>();
   var showProgress = false;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProgress=false;
  }

   @override
  Widget build(BuildContext context) {

    //To show the request Doctors menu
    Widget _requestOption() => PopupMenuButton<int>(
      icon: Icon(Icons.library_add,color: Colors.transparent,size: 50,),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child:
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  children: [
                    WidgetSpan(
                        child: Icon(CupertinoIcons.location,
                            color: Colors.blue)),
                    TextSpan(
                      text: "Home Service",
                    )
                  ])),

        ),
        PopupMenuItem(
          value: 2,
          child:RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 15.5,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  children: [
                    WidgetSpan(
                        child: Icon(
                          CupertinoIcons.phone,
                          color: Colors.blue,
                        )),
                    TextSpan(
                      text: "Call",
                    )
                  ])),
        ),
      ],
      onSelected: (selection){
        switch (selection){

          case 1:
            {
              setState(() {
                showProgress=true;
              });
              Future.delayed(const Duration(milliseconds: 5000), () {
                showProgress=true;
                Navigator.pop(context);
                _routingService.navigateTo(DoctorsRoute);

//              Navigator.pushNamed(context, LocationWithMapRoute);
              });
            }break;
          case 2:{
            setState(() {
              showProgress=true;
            });
            Future.delayed(const Duration(milliseconds: 5000), () {
              showProgress=true;
              Navigator.pop(context);
              _routingService.navigateTo(DoctorsRoute);

//              Navigator.pushNamed(context, MDservicesRoute);

            });
          }

            break;

        }
      },
      elevation: 4,
      padding: EdgeInsets.symmetric(horizontal: 50),
    );

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Dashboard',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          ///AppBar menu to allow Users SignOut
          ///
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 2.0),
                child: FlatButton(
                  color: Colors.white,
                  onPressed: (){
                    try{
                      showCupertinoDialog(context:context,
                          builder:(BuildContext context)=>CupertinoAlertDialog(

                            content: Text("Are you sure you want to Sign-Out ?",style: TextStyle(fontSize: 17),),
                            actions: <Widget>[
                              CupertinoDialogAction(

                                child: Text('No'),
                                onPressed: () {Navigator.pushNamed(context, DashboardRoute);},
                                //=> Navigator.pop(context)
                              ),
                              CupertinoDialogAction(
                                child: Text('Yes'),
                                isDestructiveAction: true,
                                onPressed: () async {
                                  try {


                                    //sinOut User On every means with firebase
                                    _authenticationService.signOut();
                                    Navigator.of(context, rootNavigator: true).pop()  ;
                                    Navigator.pushNamed(context, UnAuthenticatedPageRoute);


                                  } catch (e, s) {
                                    SnackBar(content: Text("Sorry you unable to SignOut Now"),);}
                                },

                              ),
                            ],

                          )
                      );



                    }catch(e,s){
                      SnackBar(content: Text("Sorry you unable to SignOut Now"),);

                    }
                  },
                  child: Icon(
                    FontAwesomeIcons.signOutAlt,color: Colors.black87,size: 17.5,
                  ),
                )
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top:16,right: 25,left: 25,bottom: 25),
            child: Column(children: <Widget>[

              //To show progress bar when set
              showProgress?SizedBox(child:CircularProgressIndicator(),
                height: 8,width: 8,
                  ):SizedBox(height: 0,width: 0,),

            Row(
                children: <Widget>[
                  Expanded(
                      child:

                      Container(
                        height: _container, width: _container,
                        //item content
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: (){},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //image in box
                              Container(
                                  height: _height,
                                  width: _width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/surgeon.png'),
                                        fit: BoxFit.fill),
                                  ),
                                  child:_requestOption()
                              ),
                              SizedBox(height: 10.0),

                              Text(
                                'Request Doctor',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        //item design
                        decoration: _decoration,
                      )),
                  SizedBox(width: 9),
                  Expanded(
                      child:
//                  Menu(menuImage: 'hospital', menuTitle: 'Hospitals Nearby')

                      Container(
                        height: _container, width: _width,
                        //item content
                        child: FlatButton(
                          onPressed: () {
                            _routingService.navigateTo(HospitalsRoute);
                            
                            
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //image in box
                              Container(
                                alignment: Alignment.center,
//              padding: EdgeInsets.all(30),
                                height: _height, width: _width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/hospital.png'),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text('Hospitals Nearby', style: _textStyle)
                            ],
                          ),
                        ),
                        //item design
                        decoration: _decoration,
                      )),
                ],
              ),
              SizedBox(height: 9),
              Row(
                children: <Widget>[
                  Expanded(
                      child:
//                      Menu(menuImage: 'first-aid-kit', menuTitle: 'Billing')

                      Container(
                        height: _container, width: _container,
                        //item content
                        child: FlatButton(
                          onPressed: () => Fluttertoast.showToast(msg: "Your Billing Unavailable Now"),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //image in box
                              Container(
                                height: _height,
                                width: _width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  image: DecorationImage(
                                      image:
                                      AssetImage('assets/images/first-aid-kit.png'),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text('Billing', style: _textStyle)
                            ],
                          ),
                        ),
                        //item design
                        decoration: _decoration,
                      )),
                  SizedBox(width: 9),

                  /*MY INFO*/
                  Expanded(
                      child:
                      Container(
                        height: dashboardItemHeight, width: emergencyItemWidth,
                        //item content
                        child: FlatButton(
                          onPressed: ()async{
                          setState(() {showProgress=true;});
                            try {
                            await  Future.delayed(const Duration(milliseconds: 6000), () {
                                showProgress=true;
//                                 Navigator.pop(context);
                                Navigator.pushNamed(context, MyInfoRoute);
                              });
                            }catch(e){
                              Fluttertoast.showToast(msg: "Your is Data Unavailable Now,Check Your Connection");

                          }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              //image in box
                              Container(
                                alignment: Alignment.center,
                                height: _height,
                                width: _width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/medical-history.png'),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text('My Info', style: _textStyle)
                            ],
                          ),
                        ),
                        //item design
                        decoration: _decoration,
                      )),
                ],
              ),
              SizedBox(height: 9),



              /*EMERGENCY */
              Row(
                children: <Widget>[

                  Container(
                      height: dashboardItemHeight,
                      width: 130.0,
                      //item content
                      child: FlatButton(
                        onPressed: () => Fluttertoast.showToast(msg: "Emergency Unit Unavailable Now"),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //image in box
                            Container(
                              height: _height,
                              width: emergencyInnerItemWidth,
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                image: DecorationImage(
                                    image:
                                    AssetImage('assets/images/ambulance.png'),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text('Emergenc', style: _textStyle)
                          ],
                        ),
                      ),
                      //item design
                      decoration: _decoration)
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }






  p() => print('pool');

  final BoxDecoration _decoration = BoxDecoration(
      color: Colors.white,
      border: new Border.all(
          color: Colors.greenAccent, width: 0.9, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(5)));
  final double _height = 60.789;
  final double _width = 70;
  final double _container = 140;
  final TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 14);
}
