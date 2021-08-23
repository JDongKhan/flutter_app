import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/style/jd_styles.dart';

/**
 *
 * @author jd
 *
 */

class MessageSettingPage extends StatefulWidget {
  final String title = '消息通知设置';
  @override
  State createState() => _MessageSettingPageState();
}

class _MessageSettingPageState extends State<MessageSettingPage> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: myAppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
            child: const Text(
              '当离开APP后有新消息时，你希望有',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: const Text(
                '新消息通知',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 2),
                child: const Text(
                  '可在【设置-通知-xxx】中修改',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
            child: const Text(
              '当在APP内有新消息时，你希望有',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: const Text(
                '新消息通知',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              subtitle: Container(
                padding: const EdgeInsets.only(top: 2),
                child: const Text(
                  'APP内弹窗通知',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
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
