import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/global/appuserinfo.dart';
import 'package:flutter_app_component/pages/qrcode/my_qrcode_page.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/utils/jd_navigation_util.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:jd_core/widget//blurRect/jd_blurrect.dart';
import 'package:provider/provider.dart';

import 'viewmodel/cityinfo_view_model.dart';

/**
 *
 * @author jd
 *
 */

class LeftDrawer extends StatefulWidget {
  final String title = "jd_left_drawer";

  @override
  State createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, dynamic>> _menu_list = [
    {'icon': Icons.add, 'title': '开通会员'},
    {'icon': Icons.favorite, 'title': '我的收藏'},
    {
      'icon': Icons.view_quilt,
      'title': '我的二维码',
      'click': () => JDNavigationUtil.push(MyQRcodePage()),
    },
    {'icon': Icons.feedback, 'title': '意见反馈'},
    {'icon': Icons.account_box, 'title': '关于我们'},
    {'icon': Icons.verified_user, 'title': '版本信息'}
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Stack(
          children: <Widget>[
            _buildBackground(),
            BlurRectWidget(
              child: Container(),
              sigmaX: 1,
              sigmaY: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeader(),
                _buildMenuList(),
              ],
            ),
            //天气
            Positioned(
              bottom: 20,
              left: 20,
              height: 60,
              width: 80,
              child: ProviderWidget<CityInfoViewModel>(
                model: CityInfoViewModel(),
                onModelReady: (CityInfoViewModel model) {
                  model.initData();
                },
                builder: (BuildContext c, CityInfoViewModel model) {
                  return Text('城市:${model.cityName}-天气:${model.weather}}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      JDAssetBundle.getImgPath("leftdrawer"),
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              JDNavigationUtil.pushNamed("/login");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/head.png",
                  width: 80,
                ),
              ),
            ),
          ),
          Text(
            context.watch<JDAppUserInfo>().user.name ?? "未登录",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildMenuList() {
    return Expanded(
      child: ListView(
        children: _menu_list
            .map((e) => ListTile(
                  leading: Icon(
                    e['icon'] as IconData,
                    color: Colors.white,
                  ),
                  title: Text(
                    e['title'].toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Function f = e['click'] as Function;
                    f?.call();
                  },
                ))
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
