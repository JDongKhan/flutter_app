import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/wechat/message_list/message_detail/wechat_message_detail_page.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/utils/jd_screen_utils.dart';
import 'package:lpinyin/lpinyin.dart';

/// @author jd
class WechatMailListPage extends StatefulWidget {
  @override
  _WechatMailListPageState createState() => _WechatMailListPageState();
}

class _WechatMailListPageState extends State<WechatMailListPage> {
  final List<UserInfo> _userList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    //加载城市列表
    rootBundle.loadString('assets/jsons/mail_list.json').then((value) {
      List list = json.decode(value);
      list.forEach((value) {
        _userList.add(
          UserInfo(
            name: value['name'],
            flag: value['flag'],
            icon: value['icon'],
          ),
        );
      });
      _handleList();
    });
  }

  void _handleList() {
    if (_userList == null || _userList.isEmpty) return;
    for (int i = 0, length = _userList.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(_userList[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      _userList[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        _userList[i].tagIndex = tag;
      } else {
        _userList[i].tagIndex = "#";
      }
      if (_userList[i].flag == '1') {
        _userList[i].tagIndex = '';
      }
    }
    //根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_userList);
    //显示sus tag
    SuspensionUtil.setShowSuspensionStatus(_userList);

    _userList.insert(0, UserInfo(name: '企业微信联系人', flag: '2', icon: 'wechat'));
    _userList.insert(0, UserInfo(name: '公众号', flag: '2', icon: 'other'));
    _userList.insert(0, UserInfo(name: '标签', flag: '2', icon: 'tag'));
    _userList.insert(0, UserInfo(name: '群聊', flag: '2', icon: 'qunliao'));
    _userList.insert(0, UserInfo(name: '新的朋友', flag: '2', icon: 'new_friend'));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('通讯录'),
      ),
      body: AzListView(
        data: _userList,
        itemCount: _userList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
        physics: const BouncingScrollPhysics(),
        indexBarData: SuspensionUtil.getTagIndexList(_userList),
        indexHintBuilder: (BuildContext context, String hint) {
          return Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[700].withAlpha(200),
              shape: BoxShape.circle,
            ),
            child: Text(
              hint,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          );
        },
        indexBarMargin: const EdgeInsets.all(10),
        indexBarOptions: IndexBarOptions(
          needRebuild: true,
          decoration: getIndexBarDecoration(Colors.grey[50]),
          downDecoration: getIndexBarDecoration(Colors.grey[200]),
        ),
        // susItemBuilder: (context, index) => _buildHeadWidget(index),

        //showCenterTip: false,
      ),
    );
  }

  Decoration getIndexBarDecoration(Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.grey[300], width: 0.5),
    );
  }

  Widget _buildMenu(UserInfo model) {
    return Container(
      height: 50,
      child: ListTile(
        leading: Image.asset(
          JDAssetBundle.getIconPath(model.icon, format: 'webp'),
          width: 30,
          height: 30,
          fit: BoxFit.fitWidth,
        ),
        title: Text(model.name),
      ),
    );
  }

  Widget _buildSusWidget(String susTag) {
    susTag = susTag == '★' ? '热门城市' : susTag;
    return Container(
      height: 40,
      // width: jd_screenWidth(),
      padding: const EdgeInsets.only(left: 15.0),
      color: const Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(susTag),
    );
  }

  Widget _buildListItem(int index) {
    UserInfo model = _userList[index];
    if (model.flag == '2') {
      return _buildMenu(model);
    }
    String susTag = model.getSuspensionTag();
    if (model.flag == '1') {
      susTag = '我的企业';
    }
    return Column(
      children: <Widget>[
        Offstage(
          offstage: model.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        Container(
          height: 70,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                JDAssetBundle.getImgPath(model.icon),
                width: 50,
                height: 50,
              ),
            ),
            title: Text(model.name),
            onTap: () {
              print('OnItemClick: $model');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WechatMessageDetailPage(),
                ),
              );
              // Navigator.pop(context, model);
            },
          ),
        )
      ],
    );
  }

  Widget _buildHeadWidget(int index) {
    UserInfo model = _userList[index];
    String susTag = model.tagIndex;
    susTag = susTag == '★' ? '热门城市' : susTag;
    return Container(
      height: 40,
      width: jd_screenWidth(),
      padding: const EdgeInsets.only(left: 15.0),
      color: const Color(0xfff3f4f5),
      alignment: Alignment.centerLeft,
      child: Text(
        susTag,
        softWrap: false,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xff999999),
        ),
      ),
    );
  }
}

class UserInfo extends ISuspensionBean {
  UserInfo({
    this.name,
    this.tagIndex,
    this.flag,
    this.icon,
  });
  String tagIndex;
  String name;
  String namePinyin;
  String flag;
  String icon;

  @override
  String getSuspensionTag() {
    return tagIndex;
  }
}
