import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/widgets_imports.dart';



class Role extends StatefulWidget {
  @override
  _RoleState createState() => _RoleState();
}

class _RoleState extends State<Role> {
  // Declare this variable
  int selectedRadioTile;
  int selectedRadio;
  bool _selected1=false;
  bool _selected2=false;
  Color _activeColor1;
  Color _activeColor2;

  
  //as the screen is called inititialize the values to nothing
  void iniState(){
    selectedRadio = 0;
    selectedRadioTile = 0;
    _selected1=false;
    _selected2=false;
    super.initState();
  }
// this listens to the selected Radio nand set the valur of the select role to val
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;

    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
        body: ListView(
            children: <Widget>[
              ClipPath(
                child:
                Container(
                  width: double.infinity,
                  height: 250.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),),
                    image: DecorationImage(
                        image: AssetImage('assets/images/hospitalNurse.png'),
                        fit: BoxFit.cover
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Center(child: Container(
                        height: 250, width: 50.0,
                        child: Image.asset('assets/images/splash.png'),
                      )
                      )
                  ),
                ),

              ),

              SizedBox(height: 15.0,),
              //butons
            Container(
              padding: EdgeInsets.all(15.0),
              height: 200.0,width: 500,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.blueGrey,
                    offset: new Offset(5.0, 5.0),
                    blurRadius: 2
                  ),
                ],

              ),
              //this holds the list of Radio buttons to enable users select

              child: Column(
                
                mainAxisAlignment:MainAxisAlignment.center,


                children: <Widget>[
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text("Doctor"),
                    subtitle: Text("I am a doctor"),
                    onChanged: (val) {
                      print("A doctor registered $val");
                      setSelectedRadioTile(val);
                      _selected1=true;
                      _selected2=false;
                      _activeColor1=Theme.of(context).primaryColor;
                      _activeColor2=Colors.grey;
                      setState(() {
                        selectedRadioTile =1;

                      });


                    },
                    activeColor: _activeColor1,
                    selected: _selected1,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text("Client"),
                    subtitle: Text("I am not a doctor"),
                    onChanged: (val) {
                      print("Client $val");
                      setSelectedRadioTile(val);
                      _selected2=true;
                      _selected1=false;
                      _activeColor2=Theme.of(context).primaryColor;
                      _activeColor1=Colors.grey;
                      setState(() {
                        selectedRadioTile =2;

                      });


                    },
                    activeColor: _activeColor2,

                    selected: _selected2,
                  ),

                ],
              ),
            ),
              SizedBox(height: 15,),

              SubmitButton(
                btnTitle: "Next",
                buttonHeight: 45,buttonWidth: 290,color: Theme.of(context).primaryColor,buttonPressed: roleNavigation,)

            ])


    );
  }
  roleNavigation(){
    if(selectedRadioTile==1){
      Navigator.pushNamed(context, PersonalDocumentsRoute);
    }
    else
      if(selectedRadioTile==2){
        Navigator.pushNamed(context, DashboardRoute);
      }
  }
}

//TODO use outline button to list doctors call button
