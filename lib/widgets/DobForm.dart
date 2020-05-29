import 'package:intl/intl.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/Services/authentication_services.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:mobiledoc/ui/viewmodels/dobFormVM.dart';

import 'package:stacked/stacked.dart';




class DobForm extends StatefulWidget {
  @override
  _DobFormState createState() => _DobFormState();
}

class _DobFormState extends State<DobForm> {
  String dirthOfBirth;

  int selectedYear;
  int selectedMonth;
  int selectedDay;
  Color c;
  Color btnColor=Colors.grey;
  bool _state = false;
  DateTime currentDate = DateTime.now();
  int _age;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<DobFormVm>.reactive(
      viewModelBuilder:()=>DobFormVm(),
      onModelReady: (model)=>model.initialise(),
          builder: (context,model,child)=>      SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                resizeToAvoidBottomPadding: false,
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  title: Text('Profile Details'),
                  centerTitle: true,
                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 14,
                      ),
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                ),
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 28.0, right: 18, bottom: 10, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Your Birthday',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 55.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Container(
                          padding: EdgeInsets.all(8.0),
                          constraints: BoxConstraints(maxWidth: 290, maxHeight: 290),
//                  width: 400,height: 400,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius:
                                10.0, // has the effect of softening the shadow
                                spreadRadius:
                                0.0, // has the effect of extending the shadow
                                offset: Offset(
                                  2.0, // horizontal, move right 10
                                  5.0, // vertical, move down 10
                                ),
                              )
                            ],
                          ),
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            minimumYear: 1945,
                            maximumYear: 2050,
                            onDateTimeChanged: (dateTime) {
                              setState(() {
                                dirthOfBirth = DateFormat.yMMMd().format(dateTime);
                                print(dirthOfBirth);
                                _age = currentDate.year - dateTime.year;
                                btnColor=Colors.blue;
                              });
                            },
                          )),
                      SizedBox(height: 15.0),
                      SubmitButton(
                        color: btnColor,
                        btnTitle: "Next",
                        buttonHeight: 40.0,
                        buttonWidth: 280,
                        buttonPressed: ()  {
                          btnColor==Colors.grey?
                              Fluttertoast.showToast(msg: "Avoid using invalid dates",toastLength: Toast.LENGTH_SHORT)
                              : model.updateAge(age:_age.toString());
                        },
                      )
                    ])),
          ),

      );

  }


}
