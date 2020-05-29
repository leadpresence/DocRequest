import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class DocumentLabelField extends StatelessWidget {

  final String label;
  final double spaceBtwInfoIcon;
  final Function onInfoTap;
  final String message;
//   final String messageTitle;

  DocumentLabelField({
    @required this.label,
    this.spaceBtwInfoIcon,
    @required this.message,
//     @required this.messageTitle,
    this.onInfoTap,

  });
  @override
  Widget build(BuildContext context) {


    Future<void> _handleClickMe() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(this.label),
            content: Text(this.message),
            actions: <Widget>[
//               CupertinoDialogAction(
//                 child: Text('Don\'t Allow'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
              CupertinoDialogAction(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Row(
      children: <Widget>[
        Expanded(
            child:  Row(
              children: <Widget>[
                Text(this.label),
                SizedBox(width: this.spaceBtwInfoIcon,),
                IconButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: ()=>_handleClickMe(),
                  icon:Icon(CupertinoIcons.info,
                    color:  Colors.blue[800],size: 12,),
                ),
                SizedBox(width: 80.0,),
                Expanded(child: Icon(CupertinoIcons.check_mark,color: Colors.green,),),
                SizedBox(width: 2.0,),

                Expanded(child: Icon(Icons.more_vert,color: Colors.black,),)

              ],
            )
        ),

      ],
    );




  }


}
