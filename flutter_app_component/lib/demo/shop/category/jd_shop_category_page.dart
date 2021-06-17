import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/search/jd_shop_search_page.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class JDShopCategoryPage extends StatefulWidget {
  @override
  _JDShopCategoryPageState createState() => _JDShopCategoryPageState();
}

class _JDShopCategoryPageState extends State<JDShopCategoryPage> {
  int _currentIndex = 0;
  List allMenuInfo = [
    {
      'name': '电脑',
      'subs': [
        '电脑1',
        '电脑2',
        '电脑3',
        '电脑4',
      ]
    },
    {
      'name': '手机',
      'subs': [
        '手机1',
        '手机2',
        '手机3',
        '手机4',
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildSearch(),
            Expanded(
              child: _buildSuggestions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return JDSearchBar();
  }

  Widget _buildSuggestions() {
    return Row(
      children: <Widget>[
        _buildLeft(),
        Expanded(
          child: _buildRightMenu(),
        ),
      ],
    );
  }

  Widget _buildLeft() {
    //下划线widget预定义以供复用。
    const Widget divider1 = Divider(
      height: 1,
      color: Colors.blue,
    );
    return Container(
      width: 100,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: allMenuInfo.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          return _buildRow(allMenuInfo[i], i);
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return divider1;
        },
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> map, int index) {
    final String text = map['name'];
    return InkWell(
      child: Container(
        color: index == _currentIndex ? Colors.grey[100] : Colors.white,
        alignment: Alignment.centerLeft,
        height: 40,
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14.0),
        ),
      ),
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  Widget _buildRightMenu() {
    Map map = allMenuInfo[_currentIndex];
    List currentList = map['subs'];
    return Container(
      color: Colors.grey[100],
      child: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: currentList?.length,
        padding: const EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int i) {
          String item = currentList[i];
          return InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              height: 40,
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item,
                style: const TextStyle(fontSize: 14.0),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return JDShopSearchPage();
              }));
              // _pushSaved(text, item['router'], item['page']);
            },
          );
        },
        //分割器构造器
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
