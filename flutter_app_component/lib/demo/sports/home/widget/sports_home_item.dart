import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/home/model/sports_content.dart';
import 'package:flutter_app_component/demo/sports/live/sports_live_detail_page.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';

/// @author jd

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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => SportsLiveDetailPage(),
          ),
        );
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

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userInfoWidget,
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.content.title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            JDAssetBundle.getImgPath(widget.content.img, format: 'png'),
            fit: BoxFit.fitWidth,
          )
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
                  widget.content.time,
                  style: const TextStyle(
                    fontSize: 12,
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
          Text(
            widget.content.title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Image.asset(
            JDAssetBundle.getImgPath(widget.content.img, format: 'png'),
            fit: BoxFit.fitWidth,
          )
        ],
      ),
    );
  }
}
