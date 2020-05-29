import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiledoc/ui/viewmodels/start_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:progress_indicators/progress_indicators.dart';



class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model)=>model.handleStartUp(),
        viewModelBuilder: ()=>StartUpViewModel(),
      builder: (context, model, child)=>Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 300,
                height: 100,
                child: Image.asset('assets/images/splash.png'),
              ),
              SizedBox(height: 40,),

//              CircularProgressIndicator(
//                strokeWidth: 3,
//                valueColor: AlwaysStoppedAnimation(
//                  Theme.of(context).primaryColor,
//                ),
//              )

              HeartbeatProgressIndicator(
                child: Icon(CupertinoIcons.heart,size: 80,color: Colors.white,),
              ),
            ],
          ),
        ),

    ),
    );
  }
}
