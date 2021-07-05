import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/demo/wechat/message_list/message_list/wechat_message_list_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:jd_dropdowm_menu_widget/jd_pop_widget.dart';

import '../message_detail/wechat_message_detail_page.dart';

/// @author jd

class WechatMessageListPage extends StatefulWidget {
  @override
  _WechatMessageListPageState createState() => _WechatMessageListPageState();
}

class _WechatMessageListPageState extends State<WechatMessageListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                showPop(
                  right: 10,
                  clickCallback: (index) {
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
              },
            ),
          ),
        ],
      ),
      body: ProviderWidget<WechatMessageListViewModel>(
        model: WechatMessageListViewModel(),
        builder: (context, model) {
          return ListView.separated(
              itemBuilder: (context, index) {
                Map item = model.list[index];
                return _buildListItem(model, item);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemCount: model.list.length);
        },
      ),
    );
  }

  Widget _buildListItem(WechatMessageListViewModel model, Map item) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      actions: [
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
      secondaryActions: [
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

  void _clickAtIndex(context, Map map) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WechatMessageDetailPage(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
