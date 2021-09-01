import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_component/demo/sports/home/model/sports_video.dart';
import 'package:flutter_app_component/demo/sports/home/vm/sports_home_video_vm.dart';
import 'package:flutter_app_component/demo/sports/home/vm/sports_tab_home_vm.dart';
import 'package:flutter_app_component/demo/sports/home/widget/sports_list_player.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:provider/provider.dart';

/// @author jd

class SportsHomeVideoPage extends StatefulWidget {
  @override
  _SportsHomeVideoPageState createState() => _SportsHomeVideoPageState();
}

class _SportsHomeVideoPageState extends State<SportsHomeVideoPage>
    with AutomaticKeepAliveClientMixin, LifecycleAware, LifecycleMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SportsHomeVideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ProviderWidget<SportsHomeVideoVM>(
        model: SportsHomeVideoVM(),
        builder: (BuildContext context, SportsHomeVideoVM vm) {
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(vm, index % 5);
            },
            itemCount: vm.list.length * 5,
          );
        },
      ),
    );
  }

  Widget _buildItem(SportsHomeVideoVM vm, int index) {
    SportsVideo video = vm.list[index];

    List<Widget> columnChildren = [];

    ///个人信息
    columnChildren.add(Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              JDAssetBundle.getImgPath(video.face),
              width: 40,
              height: 40,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: 200,
            child: Text(
              video.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              video.foucs == '1' ? '已关注' : '关注',
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: Color(0xffaaaaaa),
            ),
          ),
        ],
      ),
    ));

    ///title
    columnChildren.add(Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        video.title,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));

    ///播放器
    columnChildren.add(Container(
      width: jd_screenWidth(),
      height: jd_screenWidth() / 16 * 9,
      child: SportsListPlayer(
        cover: video.cover,
        videoUrl: video.videoUrl,
      ),
    ));

    ///关键词
    if (video.searchKeywork != null && video.searchKeywork.isNotEmpty) {
      columnChildren.add(Container(
        padding:
            const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                video.searchKeywork ?? '',
                style: const TextStyle(
                  color: Color(0xffaaaaaa),
                  fontSize: 13,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 14,
              color: Color(0xffaaaaaa),
            ),
          ],
        ),
      ));
    }

    ///点赞
    columnChildren.add(Container(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          JDButton(
            icon: const Icon(
              Icons.share,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: const Text(
              '分享',
              style: TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('分享'),
                      content: const Text('确定分享吗?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('取消'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('确认'),
                        ),
                      ],
                    );
                  });
            },
          ),
          JDButton(
            icon: const Icon(
              Icons.favorite,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: const Text(
              '收藏',
              style: TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {},
          ),
          JDButton(
            icon: const Icon(
              Icons.comment_bank_outlined,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: Text(
              video.commentNum ?? '评论',
              style: const TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {},
          ),
          JDButton(
            icon: const Icon(
              Icons.thumb_up_alt_outlined,
              size: 18,
              color: Color(0xffaaaaaa),
            ),
            text: Text(
              video.thumbs ?? '赞',
              style: const TextStyle(
                color: Color(0xffaaaaaa),
                fontSize: 14,
              ),
            ),
            imageDirection: AxisDirection.left,
            action: () {},
          ),
        ],
      ),
    ));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void onLifecycleEvent(LifecycleEvent event) {
    if (event == LifecycleEvent.push) {
    } else if (event == LifecycleEvent.visible) {
      SportsTabHomeVM vm = context.read<SportsTabHomeVM>();
      vm.changAppBarBackgroundColor(Colors.black);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    } else if (event == LifecycleEvent.invisible) {
      SportsTabHomeVM vm = context.read<SportsTabHomeVM>();
      vm.changAppBarBackgroundColor(Colors.blue);
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
    } else if (event == LifecycleEvent.active) {
    } else if (event == LifecycleEvent.inactive) {
    } else if (event == LifecycleEvent.pop) {}
  }
}
