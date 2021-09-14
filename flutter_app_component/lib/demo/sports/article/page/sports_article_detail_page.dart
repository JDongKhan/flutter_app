import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class SportsArticleDetailPage extends StatefulWidget {
  @override
  _SportsArticleDetailPageState createState() =>
      _SportsArticleDetailPageState();
}

class _SportsArticleDetailPageState extends State<SportsArticleDetailPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _markdown;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文章详情'),
      ),
      body: FutureBuilder<String>(
        future: JDAssetBundle.loadString('assets/data/content.md'),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _markdown = snapshot.data;
            return _buildBody();
          }
          return Container();
        },
      ),
      bottomNavigationBar: _bottomInputWidget(),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          _buildTitle(),
          _buildUserInfo(),
          _buildContentWidget(),
          _buildCommentTitleWidget(),
          _buildCommentListWidget(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return const SliverToBoxAdapter(
      child: Text(
        '足球报：贾秀全基本确认卸任 中国女足已开始选帅',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Image.asset(
              JDAssetBundle.getImgPath('user_head_0'),
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '快讯直通车',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                Text(
                  '1小时前',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('关注'),
            ),
          ],
        ),
      ),
    );
  }

  //文章
  Widget _buildContentWidget() {
    return SliverToBoxAdapter(
      child: Markdown(
        data: _markdown,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  //评论
  Widget _buildCommentTitleWidget() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          const Text(
            '65条评论',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            '热门',
            style: TextStyle(fontSize: 12),
          ),
          Container(
            color: Colors.grey,
            width: 1,
            height: 10,
            margin: const EdgeInsets.only(left: 10, right: 10),
          ),
          const Text(
            '按回复时间',
            style: TextStyle(fontSize: 12),
          ),
          IconButton(
              icon: const Icon(
                Icons.arrow_upward,
                size: 15,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildCommentListWidget() {
    return SliverList(delegate: SliverChildBuilderDelegate((context, index) {
      return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              JDAssetBundle.getImgPath('user_head_0'),
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '碧空断层赫拉德',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      JDButton(
                        action: () {},
                        icon: const Icon(
                          Icons.thumb_up_alt_outlined,
                          size: 16,
                        ),
                        text: const Text(
                          '17',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        imageDirection: AxisDirection.right,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '贾学习终于走了，可是姑娘们四年才一次的奥运呢？错失的永远都找不回来，有多少人可能都没有下届了',
                    maxLines: 10,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Text(
                        '4 回复>',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '4小时前',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }));
  }

  Widget _bottomInputWidget() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                  border: Border.all(
                    color: const Color(0xffeeeeee),
                  ),
                ),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.send,
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: '我来评论...',
                    prefixIcon: Icon(Icons.supervised_user_circle_rounded),
                    hintStyle: TextStyle(fontSize: 14),
                    border: InputBorder.none,
                    isDense: true,
                    isCollapsed: true, //相当于高度包裹的意思，必须为true，不然有默认的最小高度
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    // isDense: true,
                  ),
                ),
              ),
            ),
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
            IconButton(icon: Icon(Icons.comment), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.thumb_up_alt_outlined), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
