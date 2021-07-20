import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/get/get_simple_page.dart';

import 'get_normal_page.dart';

/// @author jd
class GetDemoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get demo list'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GetSimplePage(),
                ),
              );
            },
            child: Text('Get Simple Page'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GetNormalPage(),
                ),
              );
            },
            child: Text('Get Normal Page'),
          ),
        ],
      ),
    );
  }
}
