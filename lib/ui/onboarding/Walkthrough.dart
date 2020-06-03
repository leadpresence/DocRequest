import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/ui_import.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/ui/viewmodels/start_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:progress_indicators/progress_indicators.dart';


class WalkThrough extends StatefulWidget {
_WalkThrough createState()=>_WalkThrough();

}

class _WalkThrough extends State<WalkThrough>{
 RoutingService _routingService =locator<RoutingService>();
  @override

  void initState() {
    super.initState();

  }
  final PageController _pageViewController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final WalkthroughProvider _walkthroughProvider = Provider.of<WalkthroughProvider>(context, listen: false);


    return      ViewModelBuilder<StartUpViewModel>.reactive(
    onModelReady: (model)=>model.handleStartUp(),
    viewModelBuilder: ()=>StartUpViewModel(),
    builder: (context, model, child)=>


      Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        child:
        Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: PageView(
                controller: _pageViewController,
                onPageChanged: (int index) {
                  _walkthroughProvider.onPageChange(index);
                },
                children: <Widget>[
                  WalkThroughTemplate(
                    title: "Request Doctors",
                    subtitle:
                    "Get List Of Doctors nearby you.",
                    image: Image.asset("assets/images/walkthrough1.png"),
                  ),
                  WalkThroughTemplate(
                    title: "Book Diagnostic",
                    subtitle:
                    "Search and book diagnostic test.",
                    image: Image.asset("assets/images/walkthrough2.png"),
                  ),
                  WalkThroughTemplate(
                    title: "Request Ambulance.",
                    subtitle:
                    "Request an ambulance right away with a click.",
                    image: Image.asset("assets/images/walkthrough3.png"),
                  )
                ],
              ),
            ),
            SizedBox(height: 0.0,),

        Container(
//                      color: Theme.of(context).primaryColor,
                     decoration: BoxDecoration(
                       color: Colors.black,

                       border: Border.all(
                           color: Theme.of(context).primaryColor,
                           style: BorderStyle.solid),
//                  color: Colors.white,
                       borderRadius: BorderRadius.all(
                         Radius.circular(10.0),
                       ),
                     ),
                     child: FlatButton(
                       child:
                       Text('Create Account',style: TextStyle(color:Theme.of(context).scaffoldBackgroundColor,
                         fontSize: 16.0,
                       ),
                       ),
                       onPressed: () {
                       Navigator.pushNamed(context, UnAthCreatAccountGoogleRoute);
                       },
                       padding: EdgeInsets.all(6.0),
                     ),
                     width: 240,height: 55,
                   ),
            SizedBox(height: 15,),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(

              style:TextStyle(fontSize:14, color: Colors.black,fontWeight: FontWeight.bold),
              children: <TextSpan>[

                TextSpan(text:"Already have an account ?",style: TextStyle(color: Colors.deepOrange,)),

                TextSpan(text: "    Login ", style:TextStyle(fontSize:17,fontWeight: FontWeight.bold),
                  recognizer:new TapGestureRecognizer()..onTap = () =>
                  _routingService.navigateTo(UnAuthenticatedPageRoute),

                )
              ]),
        ),
            SizedBox(height: 10,),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(

              style:TextStyle(fontSize:10.5, color: dbasicDarkColor),
              children: <TextSpan>[

                TextSpan(text:"By continuing, I confirm that i have read & agree to the",),
                TextSpan(text: "\nTerms & conditions ",
                    recognizer:new TapGestureRecognizer()..onTap = () => print('Terms'),
                    style:TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: "and ",),
                TextSpan(text: "Privacy policy", style:TextStyle(fontWeight: FontWeight.bold),
                  recognizer:new TapGestureRecognizer()..onTap = () => print('Policy'),

                )
              ]),
        ),
      SizedBox(height: 20,)
//            Container(
//              padding: EdgeInsets.all(24.0),
//              child: Row( crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
////                   Expanded(
////                      child:
////                      WalkthroughStepper(controller: _pageViewController),
////                    ),
//                 Wrap(children: <Widget>[
//                   Container(
////                      color: Theme.of(context).primaryColor,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).scaffoldBackgroundColor,
//
//                       border: Border.all(
//                           color: Theme.of(context).primaryColor,
//                           style: BorderStyle.solid),
////                  color: Colors.white,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(30.0),
//                       ),
//                     ),
//                     child: FlatButton(
//                       child:
//                       Text('Next',style: TextStyle(color:Theme.of(context).primaryColor,
//                         fontSize: 16.0,
//                       ),
//                       ),
//                       onPressed: () {
////                         if (_pageViewController.page >= 2) {
////                           print ('last place');
////                           Navigator.of(context).pushReplacementNamed(
////                               UnAuthenticatedPageRoute);
////                         }
////                         _pageViewController.nextPage(
////                             duration: Duration(milliseconds: 500),
////                             curve: Curves.ease);
//                       },
//                       padding: EdgeInsets.all(13.0),
//                     ),
//                     width: 120,height: 55,
//                   ),
//                    SizedBox(width: 5,),
//
////                   Container(
//////                      color: Theme.of(context).primaryColor,
////                     decoration: BoxDecoration(
////                       color: Theme.of(context).scaffoldBackgroundColor,
////
////                       border: Border.all(
////                           color: Theme.of(context).primaryColor,
////                           style: BorderStyle.solid),
//////                  color: Colors.white,
////                       borderRadius: BorderRadius.all(
////                         Radius.circular(30.0),
////                       ),
////                     ),
////                     child: FlatButton(
////                       child:
////                       Text('Skip',style: TextStyle(color:Theme.of(context).primaryColor,
////                         fontSize: 16.0,
////                       ),
////                       ),
////                       onPressed: () {
////                       Navigator.pushNamed(context, UnAuthenticatedPageRoute);
////                       },
////                       padding: EdgeInsets.all(13.0),
////                     ),
////                     width: 80,height: 55,
////                   )
//                 ],)
//                ],
//              ),
//            )
          ],
        ),
      ),
    )
    );
  }


}
