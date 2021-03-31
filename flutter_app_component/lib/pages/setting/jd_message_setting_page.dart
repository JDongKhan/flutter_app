import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class JDMessageSettingPage extends StatefulWidget {

  final String title = "消息通知设置";
  @override
  State createState() => _JDMessageSettingPageState();
}

class _JDMessageSettingPageState extends State<JDMessageSettingPage> {

  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          elevation: 1,//隐藏底部阴影
          title: Text(widget.title),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10,top: 20,bottom: 10),
              child: Text('当离开APP后有新消息时，你希望有',style: TextStyle(fontSize: 12,color: Colors.black54),),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text('新消息通知',style: TextStyle(fontSize: 14,color: Colors.black87)),
                subtitle: Container(padding: EdgeInsets.only(top: 2),child: Text('可在【设置-通知-xxx】中修改',style: TextStyle(fontSize: 12,color: Colors.black54)),),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,top: 20,bottom: 10),
              child: Text('当在APP内有新消息时，你希望有',style: TextStyle(fontSize: 12,color: Colors.black54)),
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text('新消息通知',style: TextStyle(fontSize: 14,color: Colors.black87)),
                subtitle: Container(padding: EdgeInsets.only(top: 2),child: Text('APP内弹窗通知',style: TextStyle(fontSize: 12,color: Colors.black54)),),
                trailing: CupertinoSwitch(
                  value: _checked,
                  activeColor: Colors.red,
                  onChanged: (v) {
                    setState(() {
                      _checked = v;
                    });
                  },

                ),
              ),
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}