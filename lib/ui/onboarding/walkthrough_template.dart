import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WalkThroughTemplate extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image image;

  WalkThroughTemplate(
      {@required this.title, @required this.subtitle, @required this.image})
      : assert(title != null),
        assert(subtitle != null);
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Container(
      margin:EdgeInsets.only(top: 55.0) ,
      padding: EdgeInsets.only(
          top: 25.0,bottom: 24.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: image,
            ),
          ),
          Container(
            height: 180.0,
            child: Column(
              children: <Widget>[
                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,textAlign: TextAlign.justify,
                        style: _theme.textTheme.title,

                      ),
                      SizedBox(height: 10.0),
                      Text(
                        subtitle,textAlign: TextAlign.center,
                        style: _theme.textTheme.body1.merge(
                          TextStyle(
                            color: Colors.grey[600],
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
