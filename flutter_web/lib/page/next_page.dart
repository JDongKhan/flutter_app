import 'package:flutter/material.dart';

/// @author jd
class NextPage extends StatefulWidget {
  NextPage({this.id});
  final String id;
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('随便一点文字(${widget.id})'),
      ),
    );
  }
}
