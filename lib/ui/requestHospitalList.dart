import 'package:mobiledoc/Services/navigation_services.dart';
import 'package:mobiledoc/dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledoc/ui/viewmodels/request_hospitalListVM.dart';
import 'package:mobiledoc/widgets/doctorsListItem.dart';
import 'package:mobiledoc/widgets/hospitalListItem.dart';
import 'package:stacked/stacked.dart';

class RequestHospitalList
    extends StatefulWidget {
  @override
  _RequestHospitalListState createState() => _RequestHospitalListState();
}

class _RequestHospitalListState extends State<RequestHospitalList>  {
  RoutingService _routingService =locator.get<RoutingService>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestHospitalListVm>.reactive(
      viewModelBuilder: () => RequestHospitalListVm(),
      onModelReady: (model) => model.getHospitals(),
      builder: (context, model, child) =>
          SafeArea(
            child: Scaffold(
                resizeToAvoidBottomPadding: false,
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    "Hospitals",
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {

                      _routingService.navigateTo(DashboardRoute);

                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.grey,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  actions: <Widget>[
                    IconButton(icon: Icon(CupertinoIcons.search),
                    color: Colors.black,
                    onPressed: model.searchHospitalList,
                    )
                  ],
                ),
                body:
                Padding(
                  padding: EdgeInsets.only(top: 10,
                  ),
                  child: Container(
                      height: double.infinity,
                      child: model.hospitals != null?
                      ListView.builder(
                          itemCount: model.hospitals.length,
                          itemBuilder: (context, index) {
                            return
                              HospitalListItem(
                                hospital: model.hospitals[index],);
                          }

                      ) :
                      Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme
                                  .of(context)
                                  .primaryColor),
                        ),
                      ))
                  ,
                )
            ),
          ),
    );
  }




}