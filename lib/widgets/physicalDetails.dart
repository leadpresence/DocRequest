import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:mobiledoc/ui/viewmodels/physicalDetailsVM.dart';
import 'package:stacked/stacked.dart';





class PhysicalDetails extends StatefulWidget {
  @override
  _PhysicalDetails createState() => _PhysicalDetails();
}

class _PhysicalDetails extends State<PhysicalDetails> {
  String _gender;
  String _selectedHeight;
  String _selectedWeight;
  Color buttonColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return
        ViewModelBuilder<PhysicalDetailsVM>.reactive(
          viewModelBuilder: ()=>PhysicalDetailsVM(),
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
                    if (Navigator.of(context).canPop()) {
                      Navigator.pushNamed(context, BankDetailsRoute);
                    }
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
                              'Weight',
                              style: TextStyle(fontSize: 18, color: Colors.black),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              'kg',
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Text(
                              'Height',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              'cm',
                              style: TextStyle(fontSize: 10, color: Colors.black),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text('Gender', style: TextStyle(fontSize: 18)),
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
                              weight(),
                              SizedBox(
                                width: 25,
                              ),
                              height(),
                              SizedBox(
                                width: 25,
                              ),
                              gender()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(color: buttonColor,btnTitle: "NEXT",
                          buttonPressed: (){
                            model.updatePhysicalDetails(
                                _selectedWeight,
                                _selectedHeight,
                                _gender
                            );
                            print("w: " + _selectedWeight + ",H: " + _selectedHeight + " ,G: " + _gender);
                        },
                      ),
                      ],
                    ),
                  ),
                ),
              )),


        );
  }

  ///**Gender Widget

  Widget gender() {
    List<String> _genders = ["Male", "Female", "Other"];
    int selected_gender;
    Color c;
    bool _state = false;

    return Container(
      constraints: BoxConstraints(maxWidth: 50, maxHeight: 250),
      child: CupertinoPicker(
        itemExtent: 60.0,
        backgroundColor: CupertinoColors.white,
        onSelectedItemChanged: (index) {
          setState(() {
            buttonColor=Colors.blue;
            selected_gender = index ;
            switch (selected_gender) {
              case 0:
                {
                  _gender = "male";
                }
                break;
              case 1:
                {
                  _gender = "female";
                }
                break;
              case 2:
                {
                  _gender = "other";
                }
                break;
            }
            c = Colors.blue;
            print("gender: ${_gender}");
          });
        },
        children: new List<Widget>.generate(_genders.length, (index) {
          return new Center(
            child: Text(
              _genders[index].toString(),
              style: TextStyle(fontSize: 16.0, color: c),
            ),
          );
        }),
      ),
    );
  }

  ///**Height Widget

  Widget height() {
    List<int> _heights = [];
    int _selected_height;

    Color c;
    for (int weightValues = 30; weightValues < 140; weightValues++) {
      _heights.add(weightValues);
    }
    return Container(
        constraints: BoxConstraints(maxWidth: 50, maxHeight: 250),
        decoration: BoxDecoration(),
        child: CupertinoPicker(
          itemExtent: 60.0,
          backgroundColor: CupertinoColors.white,
          onSelectedItemChanged: (index) {
            setState(() {
              buttonColor=Colors.blue;

              _selected_height = index + 30;
              _selectedHeight = _selected_height.toString();
              c = Colors.blue;
            });
            print("height: ${_selected_height}");
          },
          children: new List<Widget>.generate(_heights.length, (index) {
            return new Center(
              child: Text(
                _heights[index].toString(),
                style: TextStyle(fontSize: 16.0, color: c),
              ),
            );
          }),
        ));
  }

  ///**Weight Widget

  Widget weight() {
    List<int> _weights = [];
    int _selected_weight;

    Color c;
    for (int weightValues = 10; weightValues < 140; weightValues++) {
      _weights.add(weightValues);
    }
    return Container(
        constraints: BoxConstraints(maxWidth: 50, maxHeight: 250),
        decoration: BoxDecoration(),
        child: CupertinoPicker(
          itemExtent: 60.0,
          backgroundColor: CupertinoColors.white,
          onSelectedItemChanged: (index) {
            setState(() {
              buttonColor=Colors.blue;

            _selected_weight = index + 10;
              _selectedWeight = _selected_weight.toString();

              c = Colors.blue;
              print("weight: ${_selected_weight}");
            });
          },
          children: new List<Widget>.generate(_weights.length, (index) {
            return new Center(
              child: Text(
                _weights[index].toString(),
                style: TextStyle(fontSize: 16.0, color: c),
              ),
            );
          }),
        ));
  }



  ///**Custom Button Widget
}
