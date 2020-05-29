import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobiledoc/widgets_imports.dart';
import 'package:mobiledoc/dependencies.dart';
class DoctorsReport extends StatefulWidget {
  @override
  _DoctorsReportState createState() => _DoctorsReportState();
}

class _DoctorsReportState extends State<DoctorsReport> {

//the Form
  final _doctorsReportform = new GlobalKey<FormState>();

//to get the current Date
  DateTime  _cDate =new DateTime.now();

//set variables to hold the start and ending dates
  DateTime _startDateTime;
  DateTime _endDateTime;

//my love for booleans
  bool startIsTrue=false;
  bool endIsTrue=false;

//Controllers to listen to the input fields and handle their states
  TextEditingController _emailReportCtrl= new TextEditingController();
  TextEditingController _startDateCtrl= new TextEditingController();
  TextEditingController _endDateCtrl= new TextEditingController();


//To display the date dailog  on tap of the startdate field
    Future<DateTime> _initDate (BuildContext context)async {
      final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return SingleChildScrollView(child: child,);
        },
      );
///set the startDate && end dates of report to the selected Date provided its selected
///**and provided its not the current date
      if(startIsTrue==true && selectedDate!=null && _cDate!=selectedDate){
        print("start date selected");
        setState(() {
          _startDateTime=selectedDate;
          _startDateCtrl.text= new DateFormat.yMMMd().format(_startDateTime);
          startIsTrue=false;
        });
      }
      else if(endIsTrue==true && selectedDate!=null && _cDate!=selectedDate){

        setState(() {
          _endDateTime=selectedDate;
          _endDateCtrl.text= new DateFormat.yMMMd().format(_endDateTime);
          endIsTrue=false;
        });


      }
    }


      @override
      Widget build(BuildContext context) {

        return  SafeArea(
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Doctors Report",
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
            body: SingleChildScrollView(child: _getBody()),
          ),
        );
      }




      Widget _getBody(){

        return Container(
          padding:  EdgeInsets.all(20),
          child: Form(
            key: _doctorsReportform,
            child: Column(
              children: <Widget>[


                TextFormField(
                  controller: _startDateCtrl,
                  keyboardType: TextInputType.datetime,
                  validator:  (value) {
                    if (value.isEmpty) {
                      return 'Please enter start date';
                             }
                          return null;
          },
                  onTap: (){
                    startIsTrue=true;
                    _initDate(context);


                  },
                  decoration: InputDecoration(
                      hintText: 'Start date',
                    suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)
                          )
                      )

                  ),

                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: _endDateCtrl,
                  onTap: (){
                    endIsTrue=true;
                    _initDate(context);

                  },
                  decoration: InputDecoration(
                      hintText: 'End date',
                      suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5)
                      )
                    )

                  ),
                  validator: (value) {
          if (value.isEmpty) {
          return 'Please enter end date';
          }
          return null;
          },
                ),
                SizedBox(height: 10.0,),

                TextFormField(
                  keyboardType: TextInputType.emailAddress,

                  controller: _emailReportCtrl,
                  onTap: (){

                  },
                  decoration: InputDecoration(

                      hintText: 'Enter Email',
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5)
                          )
                      )

                  ),
                  validator:  (value) {
                    if (value.isEmpty || value.contains("@",4)==false) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },

                ),
                SizedBox(height: 40,),
                 SubmitButton(color:Theme.of(context).primaryColor,btnTitle: "Request",buttonHeight: 40,buttonWidth: 270,buttonPressed: _sendRequest,)

              ],

            ),
          ),
        );





      }

  _sendRequest(){
    if (_doctorsReportform.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      Future.delayed(const Duration(microseconds: 5000000),(){
        Fluttertoast.showToast(msg: "Processing Your Request....");
        Navigator.pushNamed(context,DashboardRoute);

      });
    }

    }

    }





