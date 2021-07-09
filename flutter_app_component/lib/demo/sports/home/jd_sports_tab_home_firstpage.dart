import 'package:flutter/material.dart';
import 'package:flutter_app_component/demo/sports/live/jd_sports_live_detail_page.dart';
import 'package:jd_core/jd_core.dart';

class JDContent {
  const JDContent({
    this.title,
    this.source,
    this.comment_num,
    this.img,
    this.flag,
  });
  final String title;
  final String source;
  final String comment_num;
  final String img;
  final int flag;
}

class JDTabHomeFirstPage extends StatefulWidget {
  const JDTabHomeFirstPage(this.title);

  final String title;

  @override
  _JDTabHomeFirstPageState createState() => _JDTabHomeFirstPageState();
}

class _JDTabHomeFirstPageState extends State<JDTabHomeFirstPage> {
  List<JDContent> _allContents;

  @override
  void initState() {
    _allContents = List.generate(
      50,
      (index) => JDContent(
          title: '梅西${index}年挣6.74亿>詹皇+布雷迪生涯总和KD：太疯狂！',
          source: '网易体育',
          comment_num: '12${index}',
          img: 'bg_${index % 5}',
          flag: 0),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearch(),
        Expanded(
          child: _buildContent(),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return Container(
      color: Colors.black87,
      child: Row(
        children: [
          Expanded(child: JDSearchBar()),
          IconButton(
              icon: const Icon(
                Icons.airplay,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return ListView.separated(
      itemBuilder: (c, idx) {
        JDContent content = _allContents[idx];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => JDSportsLiveDetailPage(),
              ),
            );
          },
          child: ListTile(
            // dense: true,
            // visualDensity: VisualDensity(vertical: 10),
            contentPadding:
                const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0),
            title: Text(
              content.title,
              style: const TextStyle(color: Colors.black87, fontSize: 18),
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                '${content.source}  ${content.comment_num}评论',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            trailing: Image.asset(
              JDAssetBundle.getImgPath(content.img, format: 'jpg'),
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      separatorBuilder: (c, idx) {
        return Divider();
      },
      itemCount: _allContents.length,
    );
  }
}
