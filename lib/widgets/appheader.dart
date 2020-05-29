import 'package:flutter/material.dart';

class AppMenu extends StatelessWidget {

  Widget body;
  Key key;
  String appTitle;
  AppMenu({this.body,this.key,this.appTitle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor:Colors.transparent,

      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
     appBar: AppBar(title:Text(appTitle,style: TextStyle(color: Colors.white, fontSize: 16)) ,
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      actions: <Widget>[

      ],
      ),
      body:body ,
      key: key,
    );
  }




  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon,size: 15,),
          SizedBox(width: 5,),
          Padding(
            padding: EdgeInsets.only(left:0.2),
            child: Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)),
          ),
          SizedBox(height: 4,),

        ],
      ),
      onTap: onTap,
    );
  }


  Widget _createHeader({String text}) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(children: <Widget>[

          Positioned(
            bottom: 36,
            left: 10,
            child: Container(
              width: 80,
              height: 80,

              decoration:
              ShapeDecoration(shape: CircleBorder(),
                  color: Colors.grey[100]),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor:  Colors.greenAccent,
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage:
                    NetworkImage("https://www.rosemaryhomes.com/wp-content/uploads/avatar-placeholder-generic-1-300x300.jpg"),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text(text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }
  Widget AppDrawer(){
    return Container(
      width: 200,
      child: Drawer(

          child:
          ListView(children: <Widget>[
            _createHeader(text: "Chiueze felix"),
            _createDrawerItem(icon:Icons.phone_in_talk,text: "Your Requests",onTap: (){}),
            _createDrawerItem(icon:Icons.perm_identity,text: "Your Info",),
            _createDrawerItem(icon:Icons.payment,text: " Billings",),
            _createDrawerItem(icon:Icons.surround_sound,text: " Emergency",),
            _createDrawerItem(icon:Icons.settings,text: " Settings",),

            Divider(height: 0.5,thickness: 0.5,color: Colors.blueGrey,),
            SizedBox(height: 20,),
            _createDrawerItem(text: " mobiledoc Inc",),


          ],)
      ),
    );
  }
}
