import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDAlignPage extends StatefulWidget {

  final String title = "Align";

  @override
  State createState() => _JDAlignPageState();

}

class _JDAlignPageState extends State<JDAlignPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  alignment: Alignment.topRight,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                color: Colors.blue[50],
                child: Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment: Alignment.topRight,
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                color: Colors.blue[50],
                child: Align(
                  widthFactor: 2,
                  heightFactor: 2,
                  alignment: Alignment(2,-1),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Container(
                height: 120.0,
                width: 120.0,
                color: Colors.blue[50],
                child: Align(
                  alignment: FractionalOffset(0.2, 0.6),
                  child: FlutterLogo(
                    size: 60,
                  ),
                ),
              )

            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}