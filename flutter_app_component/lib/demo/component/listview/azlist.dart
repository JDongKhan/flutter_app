import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';

/// @author jd

class CityInfo extends ISuspensionBean {
  CityInfo({this.name, this.tagIndex});
  String tagIndex;
  String name;
  String namePinyin;

  @override
  getSuspensionTag() {
    return this.tagIndex;
  }
}

class CitySelectRoute extends StatefulWidget {
  @override
  _CitySelectRouteState createState() => _CitySelectRouteState();
}

class _CitySelectRouteState extends State<CitySelectRoute> {
  List<CityInfo> _cityList = List();
  List<CityInfo> _hotCityList = List();

  int _suspensionHeight = 40;
  int _itemHeight = 50;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    _hotCityList.add(CityInfo(name: "北京市", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "广州市", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "成都市", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "深圳市", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "杭州市", tagIndex: "★"));
    _hotCityList.add(CityInfo(name: "武汉市", tagIndex: "★"));

    //加载城市列表
    rootBundle.loadString('assets/data/china.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((value) {
        _cityList.add(CityInfo(name: value['name']));
      });
      _handleList(_cityList);
      setState(() {});
    });
  }

  void _handleList(List<CityInfo> list) {
    if (list == null || list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
//      String pinyin = 'A';
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_cityList);
  }

  Widget _buildListItem(int index) {
    CityInfo model = _cityList[index];
    String susTag = model.getSuspensionTag();
    return SizedBox(
      height: _itemHeight.toDouble(),
      child: ListTile(
        title: Text(model.name),
        onTap: () {
          print("OnItemClick: $model");
          Navigator.pop(context, model);
        },
      ),
    );
  }

  Widget _buildHeadWidget(int index) {
    CityInfo model = _cityList[index];
    String susTag = model.tagIndex;
    susTag = (susTag == "★" ? "热门城市" : susTag);
    return Container(
      height: _suspensionHeight.toDouble(),
      // width: jd_screenWidth(),
      padding: const EdgeInsets.only(left: 15.0),
      color: Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('城市选择'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 15.0),
            height: 50.0,
            child: Text("当前城市: 成都市"),
          ),
          Expanded(
            flex: 1,
            child: AzListView(
              data: _cityList,
              itemCount: _cityList.length,
              susItemBuilder: (context, index) => _buildHeadWidget(index),
              itemBuilder: (context, index) => _buildListItem(index),
              //showCenterTip: false,
            ),
          ),
        ],
      ),
    );
  }
}
