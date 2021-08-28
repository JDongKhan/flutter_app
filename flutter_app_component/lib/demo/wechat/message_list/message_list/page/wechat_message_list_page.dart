import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/shop/home/vm/custom_bouncing_scroll_physics.dart';
import 'package:flutter_app_component/demo/wechat/message_list/message_list/vm/wechat_message_list_view_model.dart';
import 'package:flutter_app_component/demo/wechat/message_list/message_list/widget/wechat_draggable_scrollable_sheet.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:jd_dropdowm_menu_widget/jd_pop_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../wechat_main_page.dart';
import '../../message_detail/page/wechat_message_detail_page.dart';
import '../widget/wechat_message_list_bottom_menu.dart';

/// @author jd

class WechatMessageListPage extends StatefulWidget {
  @override
  _WechatMessageListPageState createState() => _WechatMessageListPageState();
}

class _WechatMessageListPageState extends State<WechatMessageListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final SlidableController _slidableController = SlidableController();
  final RefreshController _refreshController = RefreshController();
  // final ScrollController _scrollController = ScrollController();

  bool _hasSubTitle = true;

  final WeChatMessageListBottomMenuController _bottomMenuController =
      WeChatMessageListBottomMenuController(initOpacity: 0);

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  //显示主页面
  void _showMainPage() {
    setState(() {
      _animationController.animateTo(1);
      hiddenBottomBar(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///底部的菜单
        WeChatMessageListBottomMenu(
          controller: _bottomMenuController,
          onBack: () {
            _showMainPage();
          },
        ),

        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            _bottomMenuController.opacity = 1 - notification.extent;
            if (notification.extent < 0.1) {
              hiddenBottomBar(true);
            }
          },
          child: WechatDraggableScrollableSheet(
            animationController: _animationController,
            expand: true,
            minChildSize: 0.0,
            maxChildSize: 1,
            initialChildSize: 1,
            builder: (
              BuildContext context,
              ScrollController scrollController,
            ) {
              return _topWidget(scrollController);
            },
          ),
        ),

        ///上层的列表
      ],
    );
  }

  Widget _topWidget(ScrollController scrollController) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            _showMainPage();
          },
          child: const Text('微信'),
        ),
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
        builder: (BuildContext context, WechatMessageListViewModel model) {
          return SmartRefresher(
            enablePullUp: true,
            enablePullDown: false,
            onLoading: _onLoading,
            controller: _refreshController,
            child: ListView.builder(
              physics: const CustomBouncingScrollPhysics(),
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                Map item = model.list[index];
                return _buildListItem(model, item);
              },
              itemCount: model.list.length,
            ),
          );
        },
      ),
    );
  }

  void _onLoading() {
    print('onLoading');
    _refreshController.refreshCompleted();
  }

  void hiddenBottomBar(bool hidden) {
    WechatMainPage.of(context).hiddenBottomNavigationBar(hidden);
  }

  ///cell布局
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

  ///cell布局
  Widget _buildListItem2(WechatMessageListViewModel model, Map item) {
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
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Row(
          children: [
            Badge(
              toAnimate: false,
              showBadge: int.parse(item['msg_count']) > 0,
              badgeContent: Text(
                item['msg_count'],
                style: const TextStyle(color: Colors.white),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  JDAssetBundle.getImgPath(
                    item['icon'],
                  ),
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['msg_name'],
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  if (_hasSubTitle)
                    Text(
                      item['msg_content'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///行点击事件
  void _clickAtIndex(BuildContext context, Map map) {
    Navigator.of(context).push(
      CupertinoPageRoute<WechatMessageDetailPage>(
        builder: (BuildContext context) => WechatMessageDetailPage(),
      ),
    );
  }

  ///下拉菜单
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
      items: [
        JDButton(
          imageDirection: AxisDirection.left,
          padding: EdgeInsets.all(0),
          middlePadding: 10,
          icon: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
          text: const Text(
            '发起群聊',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          action: () {
            setState(() {
              _hasSubTitle = !_hasSubTitle;
            });
          },
        ),
        const JDButton(
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
        const JDButton(
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
        const JDButton(
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
