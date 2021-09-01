import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/model/sports_content.dart';
import 'package:flutter_app_component/demo/sports/live/sports_live_detail_page.dart';
import 'package:flutter_app_component/utils/relative_date_format_utils.dart';
import 'package:get/get.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'sports_home_item_4_footer.dart';

/// @author jd

class SportsHomeItem extends StatelessWidget {
  const SportsHomeItem({this.content});
  final SportsContent content;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.title,
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              const Text(
                '置顶',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                content.source,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${content.commentNum} 评论',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SportsHomeItem1 extends StatefulWidget {
  const SportsHomeItem1({this.content});
  final SportsContent content;
  @override
  _SportsHomeItem1State createState() => _SportsHomeItem1State();
}

class _SportsHomeItem1State extends State<SportsHomeItem1> {
  @override
  Widget build(BuildContext context) {
    List<String> splitString = widget.content.img.split('.');
    String fileName = splitString.first;
    String fileSuffix = splitString.last;
    return GestureDetector(
      onTap: () {
        Get.to(() => SportsLiveDetailPage());
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => SportsLiveDetailPage(),
        //   ),
        // );
      },
      child: ListTile(
        // dense: true,
        // visualDensity: VisualDensity(vertical: 10),
        contentPadding:
            const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
        title: Text(
          widget.content.title,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        subtitle: Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            '${widget.content.source}  ${widget.content.commentNum}评论',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        trailing: Image.asset(
          JDAssetBundle.getImgPath(fileName, format: fileSuffix),
          width: 100,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class SportsHomeItem2 extends StatefulWidget {
  const SportsHomeItem2({this.content});
  final SportsContent content;
  @override
  _SportsHomeItem2State createState() => _SportsHomeItem2State();
}

class _SportsHomeItem2State extends State<SportsHomeItem2> {
  @override
  Widget build(BuildContext context) {
    Widget userInfoWidget = Container();
    if (widget.content.authorName.isNotEmpty) {
      userInfoWidget = Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              JDAssetBundle.getImgPath(widget.content.authorImageUrl,
                  format: 'png'),
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.content.authorName,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.content.focusStatus == '1' ? '已关注' : '关注',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      );
    }

    String tips = '';
    // ignore: null_aware_in_condition
    if (widget.content.source?.isNotEmpty) {
      tips = widget.content.source;
      tips += ' ';
    }

    // ignore: null_aware_in_condition
    if (widget.content.commentNum?.isNotEmpty) {
      tips += widget.content.commentNum;
      tips += '评论 ';
    }

    // ignore: null_aware_in_condition
    if (widget.content.time?.isNotEmpty) {
      tips += RelativeDateFormatUtils.formatFromString(widget.content.time);
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfoWidget,
          const SizedBox(
            height: 5,
          ),
          ExpandableText(
            widget.content.title,
            style: const TextStyle(fontSize: 16),
            expandText: '展开',
            collapseText: '收起',
            maxLines: 3,
            linkEllipsis: false,
            linkStyle: const TextStyle(color: Colors.blue, fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            JDAssetBundle.getImgPath(widget.content.img, format: 'png'),
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            tips,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class SportsHomeItem3 extends StatefulWidget {
  const SportsHomeItem3({this.content});
  final SportsContent content;
  @override
  _SportsHomeItem3State createState() => _SportsHomeItem3State();
}

class _SportsHomeItem3State extends State<SportsHomeItem3> {
  @override
  Widget build(BuildContext context) {
    Widget userInfoWidget = Container();
    if (widget.content.authorName.isNotEmpty) {
      userInfoWidget = Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              JDAssetBundle.getImgPath(widget.content.authorImageUrl,
                  format: 'png'),
              width: 50,
              height: 50,
              fit: BoxFit.fill,
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
                  widget.content.authorName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  RelativeDateFormatUtils.formatFromString(widget.content.time),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('关注'),
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfoWidget,
          const SizedBox(
            height: 5,
          ),
          ExpandableText(
            widget.content.title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            expandText: '展开',
            collapseText: '收起',
            maxLines: 3,
            linkEllipsis: false,
            linkStyle: const TextStyle(color: Colors.blue, fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            JDAssetBundle.getImgPath(widget.content.img, format: 'png'),
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              JDButton(
                imageDirection: AxisDirection.left,
                icon: const Icon(
                  Icons.share_outlined,
                  size: 14,
                ),
                text: const Text(
                  '分享',
                  style: TextStyle(fontSize: 14),
                ),
                action: () {},
              ),
              const SizedBox(
                width: 10,
              ),
              JDButton(
                imageDirection: AxisDirection.left,
                icon: const Icon(Icons.comment_bank_outlined, size: 14),
                text: const Text(
                  '评论',
                  style: TextStyle(fontSize: 14),
                ),
                action: () {},
              ),
              const SizedBox(
                width: 10,
              ),
              JDButton(
                imageDirection: AxisDirection.left,
                icon: const Icon(Icons.thumb_up_alt_outlined, size: 14),
                text: Text(
                  widget.content.commentNum,
                  style: const TextStyle(fontSize: 14),
                ),
                action: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SportsHomeItem4 extends StatefulWidget {
  const SportsHomeItem4({this.content});
  final SportsContent content;
  @override
  _SportsHomeItem4State createState() => _SportsHomeItem4State();
}

class _SportsHomeItem4State extends State<SportsHomeItem4> {
  final RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              footer: ShopHomeItem4Footer(),
              controller: _refreshController,
              onLoading: _onLoading,
              child: ListView.builder(
                itemCount: widget.content.videos.length,
                itemExtent: 200,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Videos videos = widget.content.videos[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            JDAssetBundle.getImgPath(videos.imgUrl,
                                format: 'png'),
                            fit: BoxFit.fitWidth,
                            width: 200,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 0,
                          right: 10,
                          child: Text(
                            videos.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.content.source,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _onLoading() {
    // _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }
}

class SportsHomeItem5 extends StatelessWidget {
  const SportsHomeItem5({this.content});
  final SportsContent content;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content.title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            content.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                '问答',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                content.source,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${content.commentNum} 评论',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Text(
                '搜索',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  content.keywords.first,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                child: Text(
                  content.keywords.last,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
