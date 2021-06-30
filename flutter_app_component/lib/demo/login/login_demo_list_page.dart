import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

import 'first/login_page.dart';
import 'second/common/login_api.dart';

/// @author jd

class LoginDemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login demo'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('First'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DemoLoginUI(),
                ),
              );
            },
          ),
          Divider(),
          Builder(
            builder: (context) => ListTile(
              title: Text('Second'),
              onTap: () {
                showLogin(context);
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Third'),
            onTap: () {
              JDNavigationUtil.pushNamed("/login");
            },
          ),
        ],
      ),
    );
  }

  void showLogin(BuildContext context) async {
    dynamic result = await LoginAPI.testLogin(context);
    print('test:$result');
  }
}
