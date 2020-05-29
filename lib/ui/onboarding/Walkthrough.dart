import 'package:mobiledoc/ui_import.dart';
import 'package:mobiledoc/dependencies.dart';


class WalkThrough extends StatefulWidget {
_WalkThrough createState()=>_WalkThrough();

}

class _WalkThrough extends State<WalkThrough>{

  @override
  void initState() {
    super.initState();

//    _checkIfIsLogged();
  }
//  _checkIfIsLogged()async {
//     await print ("user is not signed in");
//     Authservice().handleAuth();
//     //TODO Add a funtion to check if user is already existing
//  }

  final PageController _pageViewController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final WalkthroughProvider _walkthroughProvider = Provider.of<WalkthroughProvider>(context, listen: false);
    return Scaffold(
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
            Container(
              padding: EdgeInsets.all(24.0),
              child: Row( crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                   Expanded(
//                      child:
//                      WalkthroughStepper(controller: _pageViewController),
//                    ),
                 Wrap(children: <Widget>[
                   Container(
//                      color: Theme.of(context).primaryColor,
                     decoration: BoxDecoration(
                       color: Theme.of(context).scaffoldBackgroundColor,

                       border: Border.all(
                           color: Theme.of(context).primaryColor,
                           style: BorderStyle.solid),
//                  color: Colors.white,
                       borderRadius: BorderRadius.all(
                         Radius.circular(30.0),
                       ),
                     ),
                     child: FlatButton(
                       child:
                       Text('Next',style: TextStyle(color:Theme.of(context).primaryColor,
                         fontSize: 16.0,
                       ),
                       ),
                       onPressed: () {
                         if (_pageViewController.page >= 2) {
                           print ('last place');
                           Navigator.of(context).pushReplacementNamed(
                               UnAuthenticatedPageRoute);
                         }
                         _pageViewController.nextPage(
                             duration: Duration(milliseconds: 500),
                             curve: Curves.ease);
                       },
                       padding: EdgeInsets.all(13.0),
                     ),
                     width: 120,height: 55,
                   ),
                    SizedBox(width: 5,),

                   Container(
//                      color: Theme.of(context).primaryColor,
                     decoration: BoxDecoration(
                       color: Theme.of(context).scaffoldBackgroundColor,

                       border: Border.all(
                           color: Theme.of(context).primaryColor,
                           style: BorderStyle.solid),
//                  color: Colors.white,
                       borderRadius: BorderRadius.all(
                         Radius.circular(30.0),
                       ),
                     ),
                     child: FlatButton(
                       child:
                       Text('Skip',style: TextStyle(color:Theme.of(context).primaryColor,
                         fontSize: 16.0,
                       ),
                       ),
                       onPressed: () {
                       Navigator.pushNamed(context, UnAuthenticatedPageRoute);
                       },
                       padding: EdgeInsets.all(13.0),
                     ),
                     width: 80,height: 55,
                   )
                 ],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
