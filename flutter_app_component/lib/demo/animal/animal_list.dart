import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

import 'animal_1_page.dart';

/// @author jd

class AnimalListPage extends StatefulWidget {
  @override
  _AnimalListPageState createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  List item = [
    {
      'title': 'Animal 1',
      'page': Animal1Page(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动画列表'),
      ),
      body: ListView.separated(
        itemBuilder: (c, idx) {
          Map map = item[idx];
          return InkWell(
            onTap: () {
              clickItem(idx);
            },
            child: ListTile(
              title: Text(map['title']),
            ),
          );
        },
        separatorBuilder: (c, idx) {
          return const Divider(
            height: 1,
            color: Colors.blue,
          );
        },
        itemCount: item.length,
      ),
    );
  }

  void clickItem(idx) {
    Map map = item[idx];
    Widget page = map['page'];
    JDNavigationUtil.push(page);
  }
}
