import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/wechat/message_list/message_list/wechat_message_list_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:jd_dropdowm_menu_widget/jd_pop_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../wechat_main_page.dart';
import '../message_detail/wechat_message_detail_page.dart';
import 'wechat_message_list_bottom_menu.dart';

/// @author jd

class WechatMessageListPage extends StatefulWidget {
  @override
  _WechatMessageListPageState createState() => _WechatMessageListPageState();
}

enum PageStatus {
  onePage,
  twoPage,
}

class _WechatMessageListPageState extends State<WechatMessageListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  SlidableController _slidableController = SlidableController();
  RefreshController _refreshController = RefreshController();
  double _offset = 0;
  PageStatus _status = PageStatus.onePage;
  bool _animaling = false; //是否正在动画
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeChatMessageListBottomMenu(
          opacity: _opacity,
          onBack: () {
            setState(() {
              _offset = 0;
              _opacity = 0;
              _animaling = true;
              hiddenBottomBar(false);
              _status = PageStatus.onePage;
            });
            Future.delayed(const Duration(milliseconds: 1000), () {
              _animaling = false;
            });
          },
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
          transform: Matrix4.translationValues(0.0, _offset, 0.0),
          child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              automaticallyImplyLeading: false,
              title: const Text('微信'),
              actions: [
                Builder(
                  builder: (BuildContext context) => IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      _showMenu(context);
                    },
                  ),
                ),
              ],
            ),
            body: ProviderWidget<WechatMessageListViewModel>(
              model: WechatMessageListViewModel(),
              builder:
                  (BuildContext context, WechatMessageListViewModel model) {
                return SmartRefresher(
                  enablePullUp: false,
                  enablePullDown: false,
                  onRefresh: _onRefresh,
                  header: CustomHeader(
                    completeDuration: const Duration(milliseconds: 300),
                    onOffsetChange: (double offset) {
                      if (_status == PageStatus.twoPage) return;
                      //防抖动
                      if (_animaling) return;
                      if (offset < 0) return;

                      print('---- $offset --- $_offset');
                      setState(() {
                        if (offset > 130 && (offset - _offset) < 10) {
                          _handleOpacity(offset);
                        }
                        if (_offset >= offset) {
                          //说明开始回退了，回退的第一次认为pull结束了
                          _handlePullEnd();
                        } else {
                          _offset = offset;
                        }
                      });
                    },
                    builder: (BuildContext context, RefreshStatus mode) {
                      return Container();
                    },
                  ),
                  controller: _refreshController,
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Map item = model.list[index];
                        return _buildListItem(model, item);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 1,
                          color: Colors.grey,
                        );
                      },
                      itemCount: model.list.length),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _handleOpacity(double offset) {
    // print('status:${_refreshController.headerStatus}');
    _opacity = 0.5 + offset / (jd_screenHeight() - 80);
    _opacity = min(1, _opacity);
    _opacity = max(0, _opacity);
    print('opacity:$_opacity');
  }

  void _handlePullEnd() {
    _status = PageStatus.twoPage;
    _offset = jd_screenHeight() - 78;
    hiddenBottomBar(true);
    _opacity = 1;
    print('opacity1:$_opacity');
  }

  void _onRefresh() {
    print('onRefresh');
    _refreshController.refreshCompleted();
  }

  void hiddenBottomBar(bool hidden) {
    WechatMainPage.of(context).hiddenBottomNavigationBar(hidden);
  }

  Widget _buildListItem(WechatMessageListViewModel model, Map item) {
    return Slidable(
      controller: _slidableController,
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () {
            print('Archive');
          },
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () {
            print('Share');
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () {
            print('More');
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            print('Delete');
          },
        ),
      ],
      child: ListTile(
        onTap: () {
          _clickAtIndex(context, item);
        },
        title: Text(item['msg_name']),
        leading: Badge(
          toAnimate: false,
          showBadge: int.parse(item['msg_count']) > 0,
          badgeContent: Text(
            item['msg_count'],
            style: const TextStyle(color: Colors.white),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              JDAssetBundle.getImgPath(item['icon']),
            ),
          ),
        ),
        subtitle: Text(
          item['msg_content'],
        ),
      ),
    );
  }

  void _clickAtIndex(BuildContext context, Map map) {
    Navigator.of(context).push(
      MaterialPageRoute<WechatMessageDetailPage>(
        builder: (BuildContext context) => WechatMessageDetailPage(),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showPop(
      right: 10,
      clickCallback: (int index) {
        print(index);
      },
      backgroundColor: const Color(0xffaaaaff),
      barrierColor: const Color(0x00000000),
      width: 110,
      context: context,
      items: const [
        JDButton(
          imageDirection: AxisDirection.left,
          padding: EdgeInsets.all(0),
          middlePadding: 10,
          icon: Icon(
            Icons.comment,
            color: Colors.white,
          ),
          text: Text(
            '发起群聊',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        JDButton(
          imageDirection: AxisDirection.left,
          padding: EdgeInsets.all(0),
          middlePadding: 10,
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          text: Text(
            '添加朋友',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        JDButton(
          imageDirection: AxisDirection.left,
          padding: EdgeInsets.all(0),
          middlePadding: 10,
          icon: Icon(
            Icons.scanner_rounded,
            color: Colors.white,
          ),
          text: Text(
            '扫一扫',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        JDButton(
          imageDirection: AxisDirection.left,
          padding: EdgeInsets.all(0),
          middlePadding: 10,
          icon: Icon(
            Icons.payment,
            color: Colors.white,
          ),
          text: Text(
            '收付款',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
